package org.usr.usr.musicplayer;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.MediaMetadataRetriever;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.SeekBar;
import android.widget.TextView;

import java.io.File;
import java.util.ArrayList;

public class Player extends AppCompatActivity {

    int position;
    FetchSongs fs;
    ArrayList<File> mySongs;
    String path;
    ImageView albumart;
    TextView name,artist;
    ImageButton play,prev,next,playlist;
    //Thread seekUpdater;
    static seekUpdater su;
    Uri u;
    SeekBar sb;
    String artistName,songName;
    byte[] art;
    Bitmap songArt;
    MediaMetadataRetriever mmr;
    static MediaPlayer mPlayer;
    boolean notificationflag=false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_player);
        albumart=(ImageView)findViewById(R.id.albumArt);
        name=(TextView)findViewById(R.id.songName);
        artist=(TextView)findViewById(R.id.artistName);
        play=(ImageButton)findViewById(R.id.playButton);
        prev=(ImageButton)findViewById(R.id.previousButton);
        next=(ImageButton)findViewById(R.id.nextButton);
        playlist=(ImageButton)findViewById(R.id.playlistButton);
        sb=(SeekBar)findViewById(R.id.seekBar);

        if(mPlayer!=null){
            if(su!=null){
                su.endthread();
                su.interrupt();
                su=null;
            }
            mPlayer.stop();
            mPlayer.release();
        }

        fs=new FetchSongs();
        if(fs.getfetchstatus()!=true){
            mySongs=fs.findSongs(Environment.getExternalStorageDirectory());
        }
        else{
            mySongs=fs.getsonglist();
        }

        Intent intent=getIntent();
        position=intent.getIntExtra("pos",0);
        path=mySongs.get(position).toString();
        u=Uri.parse(path);

        setsongdata(path,position);
        mPlayer=MediaPlayer.create(getApplicationContext(),u);
        mPlayer.start();
        mPlayer.setLooping(true);
        play.setImageResource(R.drawable.pause);

        sb.setMax(mPlayer.getDuration());
        su=new seekUpdater(true);
        su.start();

        sb.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int i, boolean b) {

            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                mPlayer.seekTo(sb.getProgress());
            }
        });

        play.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(mPlayer.isPlaying()){
                    mPlayer.pause();
                    play.setImageResource(R.drawable.play);
                }
                else {
                    mPlayer.start();
                    play.setImageResource(R.drawable.pause);
                }
            }
        });

        next.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(su!=null){
                    su.endthread();
                    su.interrupt();
                    su=null;
                }
                mPlayer.stop();
                mPlayer.release();
                position=(position+1)%mySongs.size();
                path=mySongs.get(position).toString();
                setsongdata(path,position);
                u=Uri.parse(path);
                mPlayer=MediaPlayer.create(getApplicationContext(),u);
                mPlayer.start();
                mPlayer.setLooping(true);
                play.setImageResource(R.drawable.pause);
                sb.setMax(mPlayer.getDuration());
                sb.setProgress(mPlayer.getCurrentPosition());
                su=new seekUpdater(true);
                su.start();
            }
        });

        prev.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(su!=null){
                    su.endthread();
                    su.interrupt();
                    su=null;
                }
                mPlayer.stop();
                mPlayer.release();
                position=(position-1<0)? mySongs.size()-1:position-1;
                path=mySongs.get(position).toString();
                setsongdata(path,position);
                u=Uri.parse(path);
                mPlayer=MediaPlayer.create(getApplicationContext(),u);
                mPlayer.start();
                mPlayer.setLooping(true);
                play.setImageResource(R.drawable.pause);
                sb.setMax(mPlayer.getDuration());
                sb.setProgress(mPlayer.getCurrentPosition());
                su=new seekUpdater(true);
                su.start();
            }
        });
        playlist.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(getApplicationContext(),MainActivity.class));
            }
        });
    }

    class seekUpdater extends Thread{

        private boolean running;

        seekUpdater(boolean status){
            running=status;
        }

        public void endthread(){
            running=false;
        }

        @Override
        public void run() {
            try {
                while (running==true) {
                    int dur = mPlayer.getDuration();
                    int cur = mPlayer.getCurrentPosition();
                    while (cur < dur) {
                            sleep(500);
                            cur = mPlayer.getCurrentPosition();
                            sb.setProgress(cur);
                    }
                }
            }
            catch (InterruptedException e){
                e.printStackTrace();
                running=false;
            }
            //super.run();
        }
    }

    public void setsongdata(String songpath, int pos){
        mmr=new MediaMetadataRetriever();
        mmr.setDataSource(songpath);
        try {
            songName=mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_TITLE);
            art = mmr.getEmbeddedPicture();
            songArt = BitmapFactory.decodeByteArray(art, 0, art.length);
            artistName = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ARTIST);
            artist.setText(artistName);
            name.setText(songName);
            albumart.setImageBitmap(songArt);
        }
        catch (Exception e){
            albumart.setImageResource(R.drawable.albumart);
            artist.setText("Unknown Artist");
            name.setText(mySongs.get(pos).getName().toString().replace(".mp3", ""));
        }
    }

}

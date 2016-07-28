package org.usr.usr.unitconverter;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

public class Temp extends AppCompatActivity {


    Spinner to,from;
    EditText toet,fromet;
    Button convert;
    String[] temps={"Celsius","Fahrenheit","Kelvin"};
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_temp);
        ArrayAdapter<String> adapter=new ArrayAdapter<String>(this,android.R.layout.simple_spinner_item,temps);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        to=(Spinner)findViewById(R.id.tospinner);
        from=(Spinner)findViewById(R.id.fromspinner);
        toet=(EditText)findViewById(R.id.toedittext);
        fromet=(EditText)findViewById(R.id.fromedittext);
        convert=(Button)findViewById(R.id.button);
        to.setAdapter(adapter);
        from.setAdapter(adapter);
        convert.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String str=fromet.getText().toString();
                if(str.matches("")){
                    Toast.makeText(getApplicationContext(),"Please enter a value to convert first!",Toast.LENGTH_LONG).show();
                }
                else {
                    String fromString = (String) from.getSelectedItem();
                    String toString = (String) to.getSelectedItem();
                    double input = Double.valueOf(fromet.getText().toString());

                    // Convert the strings to something in our Unit enu,
                    tempConverter.Unit fromUnit = tempConverter.Unit.fromString(fromString);
                    tempConverter.Unit toUnit = tempConverter.Unit.fromString(toString);

                    // Create a converter object and convert!
                    tempConverter converter = new tempConverter(fromUnit, toUnit, input);
                    double result = converter.convert();
                    toet.setText(String.valueOf(result));
                }
            }
        });
    }

    @Override
    public void onBackPressed(){
        super.onBackPressed();
    }
}

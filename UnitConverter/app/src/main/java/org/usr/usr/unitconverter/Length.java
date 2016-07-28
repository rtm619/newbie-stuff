package org.usr.usr.unitconverter;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

public class Length extends AppCompatActivity {

    Spinner from, to;
    String[] length = {"Kilometre", "Metre", "Centimetre", "Inch", "Foot", "Yard", "Mile"};
    EditText fromet, toet;
    Button convert;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_length);
        ArrayAdapter<String> adapter_length = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, length);
        adapter_length.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        from = (Spinner) findViewById(R.id.fromspinner);
        to = (Spinner) findViewById(R.id.tospinner);
        from.setAdapter(adapter_length);
        to.setAdapter(adapter_length);
        fromet = (EditText) findViewById(R.id.fromedittext);
        toet = (EditText) findViewById(R.id.toedittext);
        convert = (Button) findViewById(R.id.button);
        convert.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                String str=fromet.getText().toString();
                if(str.matches("")){
                    Toast.makeText(getApplicationContext(),"Please enter a value to convert first!",Toast.LENGTH_LONG).show();
                }
                else {
                    // Get the string from the Spinners and number from the EditText
                    String fromString = (String) from.getSelectedItem();
                    String toString = (String) to.getSelectedItem();
                    double input = Double.valueOf(fromet.getText().toString());

                    // Convert the strings to something in our Unit enu,
                    lenConverter.Unit fromUnit = lenConverter.Unit.fromString(fromString);
                    lenConverter.Unit toUnit = lenConverter.Unit.fromString(toString);

                    // Create a converter object and convert!
                    lenConverter converter = new lenConverter(fromUnit, toUnit);
                    double result = converter.convert(input);
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
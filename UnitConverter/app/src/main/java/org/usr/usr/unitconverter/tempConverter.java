package org.usr.usr.unitconverter;

public class tempConverter {
    public enum Unit{
        CELSIUS,
        FAHRENHEIT,
        KELVIN;

        public static Unit fromString(String text){
            if(text!=null){
                for(Unit unit:Unit.values()){
                    if(text.equalsIgnoreCase(unit.toString())){
                        return unit;
                    }
                }
            }
            throw new IllegalArgumentException("Cannot find a value for " + text);
        }
    }

    private final double multiplier;


    public tempConverter(Unit from, Unit to, double input){
        double constant=input;
        switch (from){
            case CELSIUS:
                if(to==Unit.FAHRENHEIT){
                    constant=(input*9)/5+32;
                } else if(to==Unit.KELVIN){
                    constant=input+273.15;
                }
                break;

            case FAHRENHEIT:
                if (to==Unit.CELSIUS){
                    constant=((input-32)/9)*5;
                } else if (to==Unit.KELVIN){
                    constant=((input+459.67)/9)*5;
                }
                break;

            case KELVIN:
                if (to==Unit.CELSIUS){
                    constant=input-273.15;
                } else if (to==Unit.FAHRENHEIT){
                    constant=((input*9)/5)-459.67;
                }
                break;
        }
        multiplier=constant;
    }
    public double convert(){
        return multiplier;
    }
}

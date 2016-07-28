package org.usr.usr.unitconverter;

public class massConverter {

    public enum Unit{
        KILOGRAM,
        GRAM,
        TONNE,
        POUND,
        OUNCE;

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

    public massConverter(Unit from,Unit to){
        double constant=1;
        switch(from){
            case KILOGRAM:
                if(to==Unit.GRAM){
                    constant=1000;
                }else if (to==Unit.TONNE){
                    constant=0.001;
                } else if (to==Unit.POUND){
                    constant=2.20462;
                } else if (to==Unit.OUNCE){
                    constant=35.274;
                }
                break;

            case GRAM:
                if (to==Unit.KILOGRAM){
                    constant=0.001;
                } else if (to==Unit.TONNE){
                    constant=1e-6;
                } else if (to==Unit.POUND){
                    constant=0.00220462;
                } else if (to==Unit.OUNCE){
                    constant=0.035274;
                }
                break;

            case TONNE:
                if (to==Unit.KILOGRAM){
                    constant=1000;
                } else if (to==Unit.GRAM){
                    constant=1e+6;
                } else if (to==Unit.POUND){
                    constant=2204.62;
                } else if (to==Unit.OUNCE){
                    constant=35274;
                }
                break;

            case POUND:
                if (to==Unit.KILOGRAM){
                    constant=0.453592;
                } else if (to==Unit.GRAM){
                    constant=453.592;
                } else if (to==Unit.TONNE){
                    constant=0.000453592;
                } else if (to==Unit.OUNCE){
                    constant=16;
                }
                break;

            case OUNCE:
                if (to==Unit.KILOGRAM){
                    constant=0.0283495;
                } else if (to==Unit.GRAM){
                    constant=28.3495;
                } else if (to==Unit.TONNE){
                    constant=2.835e-5;
                } else if (to==Unit.POUND){
                    constant=0.0625;
                }
                break;
        }
        multiplier=constant;
    }

    public double convert(double input){
        return input*multiplier;
    }
}

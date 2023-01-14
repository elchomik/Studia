package costam;

import java.util.Arrays;

public class Coordinate {
    private double[] components;

    public Coordinate(double[] components) {
        if(components!=null) {
            this.components = components;
        }
        else {
            this.components = new double[0];
        }
    }

    public Coordinate(Coordinate coordinate) {
        this.components = coordinate.getComponents();
    }

    public double[] getComponents(){
        return components.clone();
    }

    public int getDimensions() {
        return getComponents().length;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Coordinate that = (Coordinate) o;
        return Arrays.equals(components, that.components);
    }

    @Override
    public int hashCode() {
        return Arrays.hashCode(components);
    }
}

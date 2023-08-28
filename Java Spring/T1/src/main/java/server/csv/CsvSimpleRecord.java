package server.csv;

import java.util.Objects;

public class CsvSimpleRecord {
    private final int bornInYear;
    private final int polishNational;
    private final int year;

    public CsvSimpleRecord(int bornInYear, int polishNational, int year) {
        this.bornInYear = bornInYear;
        this.polishNational = polishNational;
        this.year = year;
    }

    public int getBornInYear() {
        return bornInYear;
    }

    public int getPolishNational() {
        return polishNational;
    }

    public int getYear() {
        return year;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CsvSimpleRecord that = (CsvSimpleRecord) o;
        return bornInYear == that.bornInYear && polishNational == that.polishNational && year == that.year;
    }

    @Override
    public int hashCode() {
        return Objects.hash(bornInYear, polishNational, year);
    }
}

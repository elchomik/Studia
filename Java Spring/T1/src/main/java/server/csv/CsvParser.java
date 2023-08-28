package server.csv;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;

import java.awt.image.AreaAveragingScaleFilter;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class CsvParser {

    private static final String NO_BREAK_CHARACTER_FROM_EXCEL = "\uFEFF";
    private static final String EMPTY_STRING = "";
    private static final int HEADER_RECORD = 1;
    private static final String[] HEADERS = {"OVERSEAS BORN", "POLISH NATIONALS", "YEAR"};
    private final ArrayList<CsvSimpleRecord> records;

    public CsvParser() {
        this.records = new ArrayList<>();
    }

    public void parseCsvFile(String fileName) throws IOException, IllegalArgumentException {
        FileReader reader = new FileReader(fileName);
        CSVFormat.DEFAULT.builder()
                .setDelimiter(";")
                .setHeader(HEADERS)
                .setSkipHeaderRecord(false).build()
                .parse(reader)
                .stream().forEach(this::readCsvRecords);
        readAllRecords(records);
    }

    private void readCsvRecords(CSVRecord record) {
        if (record.getRecordNumber() == HEADER_RECORD) {
            validateCsvHeaders(record);
        } else {
            int overseasBorn = Integer.parseInt(record.get(HEADERS[0]));
            int polishNationals = Integer.parseInt(record.get(HEADERS[1]));
            int year = Integer.parseInt(record.get(HEADERS[2]));
            CsvSimpleRecord csvSimpleRecord = new CsvSimpleRecord(overseasBorn, polishNationals, year);
            records.add(csvSimpleRecord);
        }
    }

    private static void validateCsvHeaders(CSVRecord record) {
        List<String> transformedHeaders = Arrays.stream(record.values())
                .map(element -> element.replaceAll(NO_BREAK_CHARACTER_FROM_EXCEL, EMPTY_STRING))
                .toList();
        for (int i = 0; i < HEADERS.length; i++) {
            if (!transformedHeaders.get(i).equals(HEADERS[i])) {
                throw new IllegalArgumentException("Header at index " + i + " is invalid");
            }
        }
    }

    private void readAllRecords(List<CsvSimpleRecord> records) {
        records.forEach(record -> System.out.println("Record " + record.getYear() + " " + record.getPolishNational() + " " + record.getBornInYear()));
    }
}

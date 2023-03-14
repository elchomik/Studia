import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Main {

    private static final String NO_VALUE = "Brak";

    public static void main(String[] args) {

        try (BufferedReader bufferedReader = new BufferedReader(new FileReader("src/main/resources/katolog.txt"))) {

            System.out.printf("%-10s %-20s %-10s %-25s %-20s %-25s %-25s %-25s %-25s %-25s %-25s %-25s %-25s %-30s %-45s %-20s%n",
                    "Nr","Producent", "Ekran", "Rozdzielczość", "Powierzchnia", "Dotykowy", "Procesor", "Rdzenie", "Taktowanie",
                    "RAM", "Dysk", "Rodzaj dysku", "Układ graficzny", "Pamięć graf.", "System", "Napęd");
            System.out.print("------------------------------------------------------------------------------------------------------" +
                    "---------------------------------------------------------------------------------------------------------------"+
            "-------------------------------------------------------------------------------------------------------------------" +
                    "-------------------------\n");

            String line;
            int lineNumber = 1;
            int sonyCount = 0;
            int asusCount = 0;
            int dellCount = 0;
            int samsungCount = 0;
            int fujistsuCount = 0;
            int msiCount = 0;
            int huaweiCount =0;

            while ((line = bufferedReader.readLine()) != null) {
                String[] fields = line.split(";" ,-1);
                setTextWhenNoValue(fields);

                System.out.printf("%-10s %-20s %-10s %-25s %-20s %-25s %-25s %-25s %-25s %-25s %-25s %-25s %-25s %-30s %-45s %-20s%n",
                        lineNumber ,fields[0], fields[1], fields[2], fields[3], fields[4], fields[5], fields[6], fields[7], fields[8],
                        fields[9], fields[10], fields[11], fields[12], fields[13], fields[14]);

                switch (fields[0]) {
                    case "Asus" -> asusCount++;
                    case "Dell" -> dellCount++;
                    case "Fujitsu" -> fujistsuCount++;
                    case "Huawei" -> huaweiCount++;
                    case "MSI" -> msiCount++;
                    case "Samsung" -> samsungCount++;
                    case "Sony" -> sonyCount++;
                }
                lineNumber++;
            }

            printLaptopCounts(asusCount, fujistsuCount, dellCount, huaweiCount, samsungCount, sonyCount, msiCount);

        } catch (IOException exception) {
            exception.printStackTrace();
        }
    }

    private static void printLaptopCounts(int asusCount, int fujistsuCount, int dellCount, int huaweiCount, int samsungCount, int sonyCount, int msiCount){
        System.out.print("------------------------------------------------------------------------------------------------------" +
                "---------------------------------------------------------------------------------------------------------------"+
                "-------------------------------------------------------------------------------------------------------------------" +
                "-------------------------\n");
        System.out.printf("%nLiczba laptopów:%n");
        System.out.printf("Asus: %d%n", asusCount);
        System.out.printf("Fujistsu: %d%n", fujistsuCount);
        System.out.printf("Dell: %d%n", dellCount);
        System.out.printf("Huawei: %d%n", huaweiCount);
        System.out.printf("Samsung: %d%n", samsungCount);
        System.out.printf("Sony: %d%n", sonyCount);
        System.out.printf("MSI: %d%n", msiCount);
    }

    private static void  setTextWhenNoValue(String[] fields) {
        int i=0;
        for(String field: fields) {
            if(field.isEmpty()) {
                fields[i] = NO_VALUE;
            }
            i++;
        }
    }
}

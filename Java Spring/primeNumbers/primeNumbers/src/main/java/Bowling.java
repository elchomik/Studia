import java.util.Map;

public class Bowling {

    private int firstPinNumber;
    private int secondPinNumber;

    public Bowling() {
    }

    public Bowling(int firstPinNumber) {
        this.firstPinNumber = firstPinNumber;
    }

    public Bowling(int firstPinNumber, int secondPinNumber) {
        this.firstPinNumber = firstPinNumber;
        this.secondPinNumber = secondPinNumber;
    }

    public int getFirstPinNumber() {
        return firstPinNumber;
    }

    public int getSecondPinNumber() {
        return secondPinNumber;
    }

    public int pinsInCurrentThrow(final int pins) {
        if(pins>=0 && pins<=10) return pins;
        return 0;
    }

    public int calculatePointsInFirstGame(final int firstPinNumber, final int secondPinsNumber) {
        if(firstPinNumber == 10) {
            return 10;
        }
        final int pointsInGame= firstPinNumber + secondPinsNumber;
        return pointsInGame;
    }

    public int calculatePointsInPerfectGame(final Map<Integer,Integer> pointsInFrames) {
        return pointsInFrames.values().stream()
                .mapToInt(Integer::intValue).sum() * 3;
    }

    public int calculatePointsInWorstGame(final Map<Integer,Integer> pointsInFrames) {
        return pointsInFrames.values().stream().mapToInt(Integer::intValue).sum();
    }

    public int calculatePointsForGameWithSpare(final int firstPinNumber, final int secondPinNumber,
                                     final int frame, final int strikeInRows, final Bowling bowling) {
        if(strikeInRows == 1) {
            return 10 + 2*firstPinNumber + 2*secondPinNumber + bowling.getFirstPinNumber();
        }

        if(strikeInRows == 2){
            return 3*10 + 3*firstPinNumber + 2*secondPinNumber + bowling.getFirstPinNumber();
        }
        return (frame-1)*30 + 3*firstPinNumber + 2*secondPinNumber + bowling.getFirstPinNumber();
    }

    public int calculatePointsForGameWithStrikeSeries(final int firstPinNumber, final int secondPinNumber,
                                                      final int strikeInRows) {
        if(strikeInRows == 1){
            return 10 + 2*firstPinNumber + 2*secondPinNumber;
        }

        if(strikeInRows == 2){
            return 30 +3*firstPinNumber + 2*secondPinNumber;
        }
        return 30*(strikeInRows-1) + 3*firstPinNumber + 2*secondPinNumber;
    }

    public int calculatePointsForSpareInLastRound(final int firstPinNumber, final int secondPinNumber,
                                                  final Bowling bowling) {
        final int spareInLastRound = firstPinNumber + secondPinNumber;
        return spareInLastRound + bowling.getFirstPinNumber();
    }

    public int calculatePointsForGameWithStrikeInLastRound(final int firstPinNumber, final Bowling bowling) {
        return firstPinNumber + bowling.getFirstPinNumber() + bowling.getSecondPinNumber();
    }

}

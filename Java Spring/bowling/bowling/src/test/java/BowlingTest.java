import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;


import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;


public class BowlingTest {

    private static final int STRIKE = 10;
    private static final int SPARE = 10;
    private static final int WORST_GAME_POINTS = 0;
    private static final int PERFECT_POINTS_GAME = 300;

    private static Map<Integer,Integer> pointsInWorstFrame;
    private static Map<Integer,Integer> pointsInPerfectGame;

    @BeforeAll
    static void setUp(){
    pointsInWorstFrame = Map.of(1,0,2,0,3,0,
            4,0,5,0,6,0,7,0,
            8,0,9,0,10,0);
    pointsInPerfectGame = Map.of(1,10,2,10,3,10,
            4,10,5,10,6,10,7,10,
            8,10,9,10,10,10);
    }

    @ParameterizedTest
    @ValueSource(ints = {0,1,2,3,4,5,6,7,8,9,10})
    void pinsInCurrentThrow_ShouldReturnGivenValue(int number){
        final Bowling bowling = new Bowling(number);
        assertEquals(number,bowling.pinsInCurrentThrow(number));
    }

    @ParameterizedTest
    @ValueSource(ints = {-1,12,1042,-24})
    void pinsInCurrentThrow_ShouldReturnZeroValue(int number){
        final Bowling bowling = new Bowling(number);
        assertEquals(0,bowling.pinsInCurrentThrow(number));
    }

    @Test
    void calculatePointsInFirstGame_shouldReturnStrikeOrSparePoints() {
        final int firstPinNumber = 10;
        final int secondPinNumber = 0;
        final Bowling bowling = new Bowling(firstPinNumber,secondPinNumber);
        assertEquals(STRIKE, bowling.calculatePointsInFirstGame(firstPinNumber,secondPinNumber));

        final int firstPinNumberSpare = 3;
        final int secondPinNumberSpare = 7;
        final Bowling spareBowling = new Bowling(firstPinNumberSpare, secondPinNumberSpare);
        assertEquals(SPARE, spareBowling.calculatePointsInFirstGame(firstPinNumberSpare, secondPinNumberSpare));
    }

    @Test
    void calculatePointsInFirstGame_shouldReturnSumOfPoints(){
        final int firstPinNumber = 4;
        final int secondPinNumber = 4;
        final Bowling bowling = new Bowling(firstPinNumber, secondPinNumber);
        assertEquals(8, bowling.calculatePointsInFirstGame(firstPinNumber,secondPinNumber));
    }

    @Test
    void calculatePointsInWorstGame_shouldReturnZeroPoints(){
        final Bowling bowling = new Bowling();
        assertEquals(WORST_GAME_POINTS, bowling.calculatePointsInWorstGame(pointsInWorstFrame));
    }

    @Test
    void calculatePointsInPerfectGame_shouldReturnMaxPoints(){
        final Bowling bowling = new Bowling();
        assertEquals(PERFECT_POINTS_GAME, bowling.calculatePointsInPerfectGame(pointsInPerfectGame));
    }

    @ParameterizedTest
    @ValueSource(ints = {1,2,3,4,5,6,7,8,9,10})
    void calculatePointsForGameWithSpare_WithOneStrikeInRow(int frame){
        final int firstPinNumber = 4;
        final int secondPinNumber = 6;
        final int strikeInRow = 1;
        final int nextThrowPoints= 5;
        final Bowling bowling = new Bowling(nextThrowPoints);
        assertEquals(35,bowling
                .calculatePointsForGameWithSpare(firstPinNumber, secondPinNumber, frame, strikeInRow,bowling));
    }

    @ParameterizedTest
    @ValueSource(ints = {1,2,3,4,5,6,7,8,9,10})
    void calculatePointsForGameWithSpare_WithTwoStrikeInRow(int frame){
        final int firstPinNumber = 3;
        final int secondPinNumber = 7;
        final int strikeInRow = 2;
        final int nextThrowPoints = 5;
        final Bowling nextBowling = new Bowling(nextThrowPoints);
        assertEquals(58,nextBowling
                .calculatePointsForGameWithSpare(firstPinNumber, secondPinNumber, frame, strikeInRow,nextBowling));
    }

    @ParameterizedTest
    @ValueSource(ints = {6})
    void calculatePointsForGameWithSpare_WithStrikeSeriesInRowGreaterThanTwo(int strikeInRow){
        final int firstPinNumber = 5;
        final int secondPinNumber = 5;
        final int frame = 7;
        final int nextThrowPins = 4;
        final Bowling nextBowling = new Bowling(nextThrowPins);
        assertEquals(209, nextBowling
                .calculatePointsForGameWithSpare(firstPinNumber, secondPinNumber,
                        frame, strikeInRow, nextBowling));
    }

    @ParameterizedTest
    @ValueSource(ints={1})
    void calculatePointsForGameWithStrikeSeries_OneStrikeInRow(int strikeInRows){
        final int firtsPinNumber = 4;
        final int secondPinNumber = 2;
        final Bowling bowling = new Bowling();
        assertEquals(22,bowling
                .calculatePointsForGameWithStrikeSeries(firtsPinNumber, secondPinNumber, strikeInRows));
    }

    @ParameterizedTest
    @ValueSource(ints={2})
    void calculatePointsForGameWithStrikeSeries_TwoStrikeInRow(final int strikeInRows){
        final int firstPinNumber = 4;
        final int secondPinNumber = 3;
        final Bowling bowling = new Bowling();
        assertEquals(48, bowling
                .calculatePointsForGameWithStrikeSeries(firstPinNumber, secondPinNumber, strikeInRows));
    }

    @Test
    void calculatePointsForGameWithStrikeSeries_GreaterThanTwoAndLessThanTen(){
        final int firstPinNumber = 3;
        final int secondPinNumber = 4;
        final int strikeInRows = 8;
        final Bowling bowling = new Bowling();
        assertEquals(227,bowling
                .calculatePointsForGameWithStrikeSeries(firstPinNumber, secondPinNumber, strikeInRows));
    }

    @Test
    void calculatePointsForSpareInLastRound_shouldReturnCorrectValue(){
        final int firstPinNumber = 6;
        final int secondPinNumber = 4;
        final int nextThrowPoints = 3;
        final Bowling lastBowling = new Bowling(nextThrowPoints);
        final Bowling currentBowling = new Bowling(firstPinNumber, secondPinNumber);
        assertEquals(13,currentBowling
                .calculatePointsForSpareInLastRound(firstPinNumber,secondPinNumber, lastBowling));
    }

    @Test
    void calculatePointsForGameWithStrikeInLastRound_maxPointsInFrame(){
        final int firtPinNumberInAddedFrame = 10;
        final int secondPinNumberInAddedFrame = 10;
        final Bowling lastFrameBowling = new Bowling(10);
        final Bowling addedFrameBowling = new Bowling(firtPinNumberInAddedFrame, secondPinNumberInAddedFrame);
        assertEquals(30, lastFrameBowling
                .calculatePointsForGameWithStrikeInLastRound(lastFrameBowling.getFirstPinNumber(), addedFrameBowling));
    }

    @Test
    void calculatePointsForGameWithStrikeInLastRound_lowestPointInFrame(){
        final Bowling currentBowling = new Bowling(10);
        final Bowling addedFrameBowling = new Bowling(0,0);
        assertEquals(STRIKE, currentBowling
                .calculatePointsForGameWithStrikeInLastRound(currentBowling.getFirstPinNumber(), addedFrameBowling));
    }



}

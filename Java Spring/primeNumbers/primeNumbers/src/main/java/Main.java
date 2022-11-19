import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Scanner;

public class Main {

    private static final int STRIKE = 10;
    private static final int SPARE = 10;
    private static int FRAMES = 10;
    private static final int FIRST_FRAME = 1;
    private static int STRIKE_IN_TEN_ROWS = 0;
    private static boolean SPARE_IN_LAST_ROUND = false;
    private static boolean SPARE_IN_LAST_ROUND_AFTER_STRIKE_SERIES = false;
    private static boolean STRIKE_IN_LAST_ROUND = false;
    private static boolean PERFECT_GAME=false;
    private static boolean IS_SPEAR = false;


    public static void main(String[] args) throws Exception {
        final Scanner sc = new Scanner(System.in);
        System.out.println("Podaj liczbę graczy");
        final int gamers = sc.nextInt();
        sc.nextLine();
        final List<User> users = new ArrayList<>();

        for(int userId=0;userId<gamers;userId++){
            System.out.println("Podaj imie gracza");
            final String username = sc.nextLine();
            users.add(new User(userId,username,0));
        }

        int currentUserIndex = users.get(0).getUserId();

        for(int frame=1;frame<=FRAMES;frame++){ // main loop business logic
            System.out.println("Rozgrywka nr: "+ frame + " Rzuca gracz numer " + currentUserIndex);
            final User currentUser = users.get(currentUserIndex);
            System.out.println("Podaj ilość kręgli zbitych w pierwszym rzucie");
            final int firstPins = sc.nextInt();
            final int pinsInFirstThrow = pointsInCurrentThrow(firstPins);
            if(SPARE_IN_LAST_ROUND){
                calculatePointsAfterSpearInLastRound(currentUser,currentUser.getCurrentPointsInGame(),pinsInFirstThrow);
                SPARE_IN_LAST_ROUND=false;
            }
            else if(SPARE_IN_LAST_ROUND_AFTER_STRIKE_SERIES){
                calculatePointsAfterSpearInLastRound(currentUser,currentUser.getCurrentPointsInGame(),pinsInFirstThrow);
                SPARE_IN_LAST_ROUND_AFTER_STRIKE_SERIES = false;
            }
            else if(IS_SPEAR){
                IS_SPEAR=false;
                final int spearInPrevThrow=2*firstPins;
                setCurrentUserData(currentUser,spearInPrevThrow,frame);
            }
            else {
                setCurrentUserData(currentUser, pinsInFirstThrow, frame);
            }
        }

        users.forEach(user -> System.out.println( "Ilość zdobytych punktów w grze " + user.getCurrentPointsInGame()));
    }

    private static void calculatePointsAfterSpearInLastRound(final User currentUser, final int points,
                                                            final int pointsInAdditionalThrow){
        final int pointsInGame = points + pointsInAdditionalThrow;
        currentUser.setCurrentPointsInGame(pointsInGame);
    }

    private static int pointsInCurrentThrow(final int pins) throws Exception {
        if(pins>=0 && pins<=10) return pins;
        else throw new Exception("Nie poprawna ilość kręgli");
    }

    private static int countPointsInFirstFrame(final int frame, final int firstThrowPin,final Scanner scanner) {
        int currentPointsInGame=0;
        if(frame == FIRST_FRAME){
            if(firstThrowPin == STRIKE){
                STRIKE_IN_TEN_ROWS +=1;
                currentPointsInGame+= STRIKE;
            }
            else{
                System.out.println("Podaj ilość kręgli zbitych w drugim rzucie");
                final int secondPins = scanner.nextInt();
                if(secondPins == SPARE){
                    currentPointsInGame+=SPARE;
                }
                else {
                    currentPointsInGame += firstThrowPin + secondPins;
                }
            }
        }
        return currentPointsInGame;
    }

    private static int calculatePointsForGameWithStrikeSeries(int currentPointsInGame, final int frame) {
        STRIKE_IN_TEN_ROWS +=1;
        if(STRIKE_IN_TEN_ROWS ==0) {
            currentPointsInGame = STRIKE;
        }
        else if(STRIKE_IN_TEN_ROWS == 10) {
            PERFECT_GAME = true;
            System.out.println("Uzyskałeś dwa dodatkowe rzuty");
            FRAMES+=1;
            currentPointsInGame = 280;
        }
        else if(frame == 10){
            STRIKE_IN_LAST_ROUND=true;
            System.out.println("Uzyskałeś dodatkowe dwa rzuty ");
            FRAMES+=1;
            currentPointsInGame=currentPointsInGame + STRIKE;
        }
        return currentPointsInGame;
    }

    private static int calculatePointsForGameWithSpare(final int frame, final int firstPinNumber, final int secondPinNumber) {
        int currentPointsInGame;
        if(STRIKE_IN_TEN_ROWS == 1){
            currentPointsInGame =STRIKE+ 2*firstPinNumber + 2*secondPinNumber;
        }
        else if(STRIKE_IN_TEN_ROWS == 2){
            currentPointsInGame =2*firstPinNumber + 2*secondPinNumber;
        }
        else if(STRIKE_IN_TEN_ROWS == 9){
            System.out.println("Uzyskałeś dodatkowy rzut");
            SPARE_IN_LAST_ROUND_AFTER_STRIKE_SERIES =true;
            currentPointsInGame =(frame - 1)*30 +3*firstPinNumber + 2*secondPinNumber;
            FRAMES +=1;
        }
        else {
            currentPointsInGame =(frame - 1)*30 +3*firstPinNumber + 2*secondPinNumber;
        }
        return currentPointsInGame;
    }

    private static int calculatePointsForStrikeSeries(final int strikeInRows, final int firstPinNumber,
                                                       final int secondPinNumber, int currentPointsInGame) {
        if (strikeInRows == 1) {
            currentPointsInGame += 10 +  2* firstPinNumber  + 2*secondPinNumber;
        } else if (strikeInRows == 2) {
            currentPointsInGame += STRIKE * 3  + 3 * firstPinNumber + 2*secondPinNumber;
        } else {
            currentPointsInGame += 3 * (strikeInRows - 1) * 10 + 3 *firstPinNumber + 2*secondPinNumber;
        }
        return currentPointsInGame;
    }


    private static void setCurrentUserData(final User currentUser, final int firstPinNumber, final int frame){
        final FrameVO currentFrame = currentUser.getFrameVO();
        final Scanner scanner = new Scanner(System.in);
        if(Objects.isNull(currentFrame)){
            int curentPointsInGame= countPointsInFirstFrame(frame,firstPinNumber, scanner);
            setUserWithFrame(frame,curentPointsInGame,currentUser);
        }
        else{
            int currentPointsInGame = currentUser.getCurrentPointsInGame();

            if(SPARE_IN_LAST_ROUND_AFTER_STRIKE_SERIES) {
                currentPointsInGame= currentUser.getCurrentPointsInGame() + firstPinNumber;
                setUserWithFrame(frame,currentPointsInGame,currentUser);
                FRAMES=10;
            }

            if(SPARE_IN_LAST_ROUND){
                currentPointsInGame=currentUser.getCurrentPointsInGame() + firstPinNumber;
                setUserWithFrame(frame,currentPointsInGame,currentUser);
                FRAMES=10;
            }

            if(STRIKE_IN_LAST_ROUND) {
                currentPointsInGame=currentUser.getCurrentPointsInGame() + firstPinNumber;
                setUserWithFrame(frame,currentPointsInGame,currentUser);
                STRIKE_IN_LAST_ROUND=false;
            }

            if(PERFECT_GAME){
                setUserWithFrame(frame,300,currentUser);
                PERFECT_GAME=false;
            }

            if(firstPinNumber == STRIKE){
                final int pointsForGameWithStrikeSeries = calculatePointsForGameWithStrikeSeries(currentUser
                        .getCurrentPointsInGame(), frame);
                setUserWithFrame(frame,pointsForGameWithStrikeSeries, currentUser);
            }
            else{
                System.out.println("Podaj ilość kręgli zbitych w drugim rzucie");
                final int secondPins = scanner.nextInt();
                int spare = secondPins + firstPinNumber;
                if(spare == SPARE){
                    if(STRIKE_IN_TEN_ROWS !=0){
                        currentPointsInGame = calculatePointsForGameWithSpare(frame, firstPinNumber, secondPins);
                        setUserWithFrame(frame, currentPointsInGame, currentUser);
                    }
                    else if(frame == 10){
                        SPARE_IN_LAST_ROUND=true;
                        FRAMES+=1;
                        System.out.println("Uzyskałeś dodatkowy rzut");
                        currentPointsInGame= currentUser.getCurrentPointsInGame() + spare;
                        setUserWithFrame(frame, currentPointsInGame, currentUser);
                    }
                    else {
                        IS_SPEAR=true;
                        currentPointsInGame += SPARE;
                        setUserWithFrame(frame, currentPointsInGame, currentUser);
                    }
                }
                else {
                    if(STRIKE_IN_TEN_ROWS != 0) {
                        currentPointsInGame = calculatePointsForStrikeSeries(STRIKE_IN_TEN_ROWS, firstPinNumber,
                                secondPins, currentUser.getCurrentPointsInGame());
                        setUserWithFrame(frame, currentPointsInGame, currentUser);
                    }
                    else {
                        currentPointsInGame += firstPinNumber + secondPins;
                        setUserWithFrame(frame, currentPointsInGame, currentUser);
                    }
                }
                STRIKE_IN_TEN_ROWS =0;
            }
        }
    }


    private static void setUserWithFrame(final int frame, final int points,
                                  final User currentUser){
        final FrameVO currentFrameVO = new FrameVO(frame,points);
        currentUser.setCurrentPointsInGame(points);
        currentUser.setFrameVO(currentFrameVO);
    }
}

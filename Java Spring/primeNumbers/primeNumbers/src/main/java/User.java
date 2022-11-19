import java.util.List;

public class User {

    private final int userId;
    private final String name;
    private int currentPointsInGame;

    private FrameVO frameVO;

    public User(final int userId, final String name, final int currentPointsInGame) {
        this.userId = userId;
        this.name = name;
        this.currentPointsInGame = currentPointsInGame;
    }

    public int getUserId() {
        return userId;
    }

    public String getName() {
        return name;
    }

    public int getCurrentPointsInGame() {
        return currentPointsInGame;
    }

    public FrameVO getFrameVO() {
        return frameVO;
    }

    public void setFrameVO(FrameVO frameVO) {
        this.frameVO = frameVO;
    }

    public void setCurrentPointsInGame(int currentPointsInGame) {
        this.currentPointsInGame = currentPointsInGame;
    }
}

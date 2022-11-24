public class FrameVO {

    private final int frameNumber;
    private final int pointsInFrame;


    public FrameVO(int frameNumber, int pointsInFrame) {
        this.frameNumber = frameNumber;
        this.pointsInFrame = pointsInFrame;
    }

    public int getFrameNumber() {
        return frameNumber;
    }

    public int getPointsInFrame() {
        return pointsInFrame;
    }

}

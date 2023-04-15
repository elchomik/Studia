package anemic_model.excpetions;

public class BlockedCardException extends IllegalArgumentException {
    public BlockedCardException(String s) {
        super(s);
    }
}

package anemic_model.excpetions;

public class ChangedCardLimitException extends IllegalArgumentException{
    public ChangedCardLimitException(String s) {
        super(s);
    }
}

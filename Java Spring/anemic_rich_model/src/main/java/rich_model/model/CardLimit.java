package rich_model.model;

import rich_model.model.exceptions.CardStateExcpetion;

import java.math.BigDecimal;
import java.util.Objects;

/*
Value Object
*/
public class CardLimit {

    private final BigDecimal value;

    private CardLimit(BigDecimal value) {
        if(Objects.isNull(value)) throw new CardStateExcpetion("Limit was not provided");
        if(value.compareTo(BigDecimal.ZERO) > 0) throw new CardStateExcpetion("Limit must be 0");
        this.value = value;
    }

    public static CardLimit of(final BigDecimal limit) {
        return new CardLimit(limit);
    }
}

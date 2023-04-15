package anemic_model.model;

import java.math.BigDecimal;
import java.util.UUID;

public class Card {
    private UUID cardId;
    private String cardNumber;
    private BigDecimal limit;
    private boolean isBlocekd;
    private boolean isActive;



    public UUID getCardId() {
        return cardId;
    }

    public void setCardId(UUID cardId) {
        this.cardId = cardId;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public boolean isBlocekd() {
        return isBlocekd;
    }

    public void setBlocekd(boolean blocekd) {
        isBlocekd = blocekd;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public BigDecimal getLimit() {
        return limit;
    }

    public void setLimit(BigDecimal limit) {
        this.limit = limit;
    }
}

package rich_model.model;

import rich_model.exceptions.CardStateExcpetion;

import java.math.BigDecimal;
import java.util.UUID;

public class Card {

    private static final CardLimit DEFAULT_CARD_LIMIT = CardLimit.of(BigDecimal.valueOf(1000L));

    private final UUID cardId;
    private final String cardNumber;
    private CardLimit cardLimit;
    private boolean isBlocked;
    private boolean isActive;

    private Card(UUID cardId, String cardNumber, CardLimit cardLimit, boolean isBlocked, boolean isActive) {
        this.cardId = cardId;
        this.cardNumber = cardNumber;
        this.cardLimit = cardLimit;
        this.isBlocked = isBlocked;
        this.isActive = isActive;
    }

    public static Card createCard(UUID cardId, String cardNumber) {
        return new Card(cardId, cardNumber, DEFAULT_CARD_LIMIT, false, false);
    }

    public UUID getCardId() {
        return cardId;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public CardLimit getCardLimit() {
        return cardLimit;
    }

    public void block() {
        if (canCardBeBlocked()) throw new CardStateExcpetion("Card can't be blocked");
        this.isBlocked = true;
    }

    public void changeCardLimit(CardLimit newLimit) {
        if (canChangeCardLimit()) throw new CardStateExcpetion("Couldn't change card limit");
        this.cardLimit = newLimit;
    }

    public void activate() {
        if (canCardBeActivate()) throw new CardStateExcpetion("Card can't be activate");
        this.isActive = true;
        this.cardLimit = DEFAULT_CARD_LIMIT;
    }

    private boolean canChangeCardLimit() {
        return isActive && !isBlocked;
    }

    private boolean canCardBeBlocked() {
        return isActive && !isBlocked;
    }

    private boolean canCardBeActivate() {
        return !isActive && !isBlocked;
    }

}

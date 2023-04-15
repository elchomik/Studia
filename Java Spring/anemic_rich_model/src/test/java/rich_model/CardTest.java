package rich_model;

import org.junit.jupiter.api.Test;
import rich_model.exceptions.CardStateExcpetion;
import rich_model.model.Card;
import rich_model.model.CardLimit;

import java.math.BigDecimal;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class CardTest {

    private static final CardLimit ANY_LIMIT = CardLimit.of(BigDecimal.valueOf(500L));

    @Test
    public void canNotBlockAlreadyBlockedCard() {
        Card card = givenBlockedCard();
        assertThrows(CardStateExcpetion.class, card::block);
    }

    @Test
    public void canNotBlockActivatedCard() {
        Card card = givenNotActiveCard();
        assertThrows(CardStateExcpetion.class, card::block);
    }

    @Test
    public void blockActivatedCard() {
        Card card = givenActiveCard();
        assertDoesNotThrow(card::block);
    }

    @Test
    public void canNotActivateBlockedCard() {
        Card card = givenBlockedCard();
        assertThrows(CardStateExcpetion.class, card::activate);
    }

    @Test
    public void canNotActivateAlreadyActiveCard() {
        Card card = givenActiveCard();
        assertThrows(CardStateExcpetion.class, card::activate);
    }

    @Test
    public void activatesNewCard() {
        Card card = givenNotActiveCard();
        assertDoesNotThrow(card::activate);
    }

    @Test
    public void canNotChangeLimitOnBlockedCard() {
        Card card = givenBlockedCard();
        assertThrows(CardStateExcpetion.class,() -> card.changeCardLimit(ANY_LIMIT));
    }

    @Test
    public void changesLimitActivateCard() {
        Card card = givenActiveCard();
        assertDoesNotThrow(() -> card.changeCardLimit(ANY_LIMIT));
    }

    private Card givenNotActiveCard() {
        return givenCard();
    }

    private Card givenBlockedCard() {
        Card card = givenCard();
        card.activate();
        card.block();
        return card;
    }

    private Card givenActiveCard() {
        Card card = givenCard();
        card.activate();
        return card;
    }

    private Card givenCard() {
        final UUID cardId = UUID.randomUUID();
        final String cardNumber = UUID.randomUUID().toString();
        return Card.createCard(cardId, cardNumber);
    }
}

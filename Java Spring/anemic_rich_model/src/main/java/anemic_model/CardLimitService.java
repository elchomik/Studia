package anemic_model;


import anemic_model.excpetions.ChangedCardLimitException;
import anemic_model.infrastructure.CardRepository;
import anemic_model.model.Card;

import java.math.BigDecimal;
import java.util.Objects;
import java.util.UUID;

public class CardLimitService {

    private final CardRepository cardRepository;

    public CardLimitService(CardRepository cardRepository) {
        this.cardRepository = cardRepository;
    }

    public void changeCardLimit(UUID cardId, BigDecimal limit) {
        Card card = cardRepository.loadCardById(cardId)
                .orElseGet(Card::new);

        validateIsCardBlocked(card);
        validateIsCardNotActive(card);
        validateCardLimit(limit);
    }

    private void validateCardLimit(BigDecimal limit) {
        if(Objects.isNull(limit)) throw  new IllegalArgumentException("Limit was not provided");

        if(limit.compareTo(BigDecimal.ONE) < 0) throw new ChangedCardLimitException("Limit is zero");
    }

    private void validateIsCardNotActive(Card card) {
        if(!card.isActive()) throw new ChangedCardLimitException("Card is not active");
    }

    private void validateIsCardBlocked(Card card) {
        if(card.isBlocekd()) throw new ChangedCardLimitException("Card is blocked");
    }
}

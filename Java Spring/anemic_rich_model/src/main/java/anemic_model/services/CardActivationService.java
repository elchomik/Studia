package anemic_model.services;

import anemic_model.excpetions.ActivateCardException;
import anemic_model.infrastructure.CardRepository;
import anemic_model.model.Card;

import java.math.BigDecimal;
import java.util.UUID;

public class CardActivationService {

    private final BigDecimal DEFAULT_LIMIT = BigDecimal.valueOf( 1000L);
    private final CardRepository cardRepository;

    public CardActivationService(CardRepository cardRepository) {
        this.cardRepository = cardRepository;
    }

    public void activateCard(UUID cardId) {
        Card card = cardRepository.loadCardById(cardId)
                .orElseThrow(IllegalArgumentException::new);

        validateIsCardBlocked(card);
        validateIsCardActive(card);

        card.setActive(true);
        card.setLimit(DEFAULT_LIMIT);

        cardRepository.save(card);
    }

    private void validateIsCardActive(Card card) {
        if(card.isActive()) {
            throw new ActivateCardException("Card is yet active");
        }
    }

    private void validateIsCardBlocked(Card card) {
        if(card.isBlocekd()){
            throw new ActivateCardException("Card couldn't be activate");
        }
    }
}

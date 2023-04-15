package anemic_model.services;

import anemic_model.excpetions.BlockedCardException;
import anemic_model.infrastructure.CardRepository;
import anemic_model.model.Card;

import java.util.UUID;

public class CardBlockedService {

    private final CardRepository cardRepository;

    public CardBlockedService(CardRepository cardRepository) {
        this.cardRepository = cardRepository;
    }

    private void blockCard(UUID cardId) {
        Card card = cardRepository.loadCardById(cardId).orElseThrow(IllegalArgumentException::new);

        validateIsCardBlocked(card);
        validateIsCardNotActive(card);

        card.setBlocekd(true);

        cardRepository.save(card);
    }

    private void validateIsCardNotActive(Card card) {
        if(!card.isActive()) throw new BlockedCardException("Card couldn't be blocked");
    }

    private void validateIsCardBlocked(Card card) {
        if(card.isBlocekd()) throw new BlockedCardException("Card couldn't be blocked");
    }
}

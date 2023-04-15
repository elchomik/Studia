package anemic_model.infrastructure;

import anemic_model.infrastructure.CardRepository;
import anemic_model.model.Card;

import java.util.Optional;
import java.util.Set;
import java.util.UUID;

public class CardRepositoryImpl implements CardRepository {

    private static final String UUID_ID = "a1b2c3d4-e5f6-4a4a-9b9b-1c1d1e1f1c1e";
    private Set<Card> cards;
    private Card card;

    public CardRepositoryImpl() {
        Card card = new Card();
        card.setActive(false);
        card.setCardId(UUID.fromString(UUID_ID));
        card.setCardNumber("cos");
        card.setBlocekd(false);
        cards = Set.of(card);
    }

    @Override
    public Optional<Card> loadCardById(UUID cardId) {
        return cards.stream()
                .filter(card -> card.getCardId() == cardId)
                .findFirst();
    }

    @Override
    public void save(Card card) {
        cards.add(card);
    }
}

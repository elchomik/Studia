package anemic_model.infrastructure;

import anemic_model.infrastructure.CardRepository;
import anemic_model.model.Card;

import java.util.Optional;
import java.util.Set;
import java.util.UUID;

public class CardRepositoryImpl implements CardRepository {

    private Set<Card> cards;
    private Card card;

    public CardRepositoryImpl() {
        card = new Card();
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

package anemic_model.infrastructure;

import anemic_model.model.Card;

import java.util.Optional;
import java.util.UUID;

public interface CardRepository {

    Optional<Card> loadCardById(UUID cardId);

    void save(Card card);
}

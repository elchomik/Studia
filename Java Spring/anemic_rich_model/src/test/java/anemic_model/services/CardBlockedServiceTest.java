package anemic_model.services;

import anemic_model.CardBlockedService;
import anemic_model.excpetions.BlockedCardException;
import anemic_model.infrastructure.CardRepository;
import anemic_model.model.Card;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Optional;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class CardBlockedServiceTest {

    private static final String UUID_ID = "a1b2c3d4-e5f6-4a4a-9b9b-1c1d1e1f1c1e";

    @Mock
    private CardRepository cardRepository;

    @InjectMocks
    private CardBlockedService cardBlockedService;

    @BeforeEach
    public void init() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void shouldThrowsException_blockCard() {
        //GIVEN

        Card card = new Card();

        //WHEN
        when(cardRepository.loadCardById(UUID.fromString(UUID_ID))).thenReturn(Optional.of(card));

        //THEN
        Assertions.assertThrows(BlockedCardException.class, () -> {
            cardBlockedService.blockCard(UUID.fromString(UUID_ID));
        });
    }
}

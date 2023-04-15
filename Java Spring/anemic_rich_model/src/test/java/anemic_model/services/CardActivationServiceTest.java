package anemic_model.services;

import anemic_model.CardActivationService;
import anemic_model.excpetions.ActivateCardException;
import anemic_model.infrastructure.CardRepository;
import anemic_model.model.Card;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class CardActivationServiceTest {

    private static final String UUID_ID = "a1b2c3d4-e5f6-4a4a-9b9b-1c1d1e1f1c1e";
    @Mock
    private CardRepository cardRepository;

    @InjectMocks
    private CardActivationService cardActivationService;

    @BeforeEach
    public void init() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void shouldPass_activateCard() {
        //GIVEN
        Card card = new Card();
        card.setActive(false);
        card.setCardId(UUID.fromString(UUID_ID));
        card.setCardNumber(any(String.class));
        card.setBlocekd(false);

        //WHEN
        when(cardRepository.loadCardById(UUID.fromString(UUID_ID))).thenReturn(Optional.of(card));
        cardActivationService.activateCard(UUID.fromString(UUID_ID));

        //THEN
        verify(cardRepository).save(any(Card.class));
    }
}

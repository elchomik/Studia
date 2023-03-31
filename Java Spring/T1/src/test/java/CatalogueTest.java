import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class CatalogueTest {

    @Test
    void isInputContainsOnlyString_InputIsString_True() {

        //given
        Catalogue catalogue = Mockito.spy(new Catalogue());

        //when
        when(catalogue.isInputContainsOnlyString("Screen")).thenReturn(true);

        //assert
        assertTrue(catalogue.isInputContainsOnlyString("Screen"));
    }

    @Test
    void isInputContainsOnlyString_InputIsString_False() {
        //given
        Catalogue catalogue = mock(Catalogue.class);

        //when
        when(catalogue.isInputContainsOnlyString("Screen123")).thenReturn(false);

        //assert
        assertFalse(catalogue.isInputContainsOnlyString("Screen123"));
    }


    @Test
    void isInputContainsOnlyDigit_InputIsString_True() {
        //given
        Catalogue catalogue = mock(Catalogue.class);

        //when
        when(catalogue.isInputContainsOnlyDigit("12341")).thenReturn(true);

        //assert
        assertTrue(catalogue.isInputContainsOnlyDigit("12341"));
    }


}

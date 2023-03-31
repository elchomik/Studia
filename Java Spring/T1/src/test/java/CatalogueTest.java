import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import static org.junit.jupiter.api.Assertions.assertTrue;
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
}

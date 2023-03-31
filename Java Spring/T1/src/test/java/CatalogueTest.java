import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.mockito.Mockito;

import java.util.stream.IntStream;

import static org.junit.jupiter.api.Assertions.*;
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


    @Test
    void isInputContainsOnlyDigit_InputIsString_False() {
        //given
        Catalogue catalogue = mock(Catalogue.class);

        //when
        when(catalogue.isInputContainsOnlyDigit("12323ssdds23")).thenReturn(false);

        //assert
        assertFalse(catalogue.isInputContainsOnlyDigit("12323ssdds23"));
    }

    @ParameterizedTest
    @DisplayName("Columns with String validation")
    @ValueSource(ints ={1,4,5,6,11,12,14,15})
    void isColumnWithStringValidation_InputIsInt_True(int column){
        //given
        Catalogue catalogue = mock(Catalogue.class);

        //when
        when(catalogue.isColumnWithStringValidation(column)).thenReturn(true);

        //assert
        assertTrue(catalogue.isColumnWithStringValidation(column));
    }

    @ParameterizedTest
    @DisplayName("Columns without String validation")
    @ValueSource(ints = {0,2,3,7,8,9,10,11,13})
    void isColumnWithoutStringValidation_InputIsInt_False(int column) {
        //given
        Catalogue catalogue = mock(Catalogue.class);

        //when
        when(catalogue.isColumnWithStringValidation(column)).thenReturn(false);

        //assert
        assertFalse(catalogue.isColumnWithStringValidation(column));
    }

    @Test
    void shouldDisplaySpecifiedTextWhenInputIsEmpty(){
        String[] values = new String[]{"co", "tam", "" };

        IntStream.range(0, values.length)
                .filter(i -> values[i].isEmpty())
                .forEach(i -> values[i] = "Brak");

        assertEquals("co", values[0]);
        assertEquals("tam", values[1]);
        assertEquals("Brak", values[2]);
    }
}

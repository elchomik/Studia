import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.mockito.Mockito;
import server.Server;

import java.util.stream.IntStream;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class ServerTest {

    @Test
    void isInputContainsOnlyString_InputIsString_True() {

        //given
        Server server = Mockito.spy(new Server());

        //when
        when(server.isInputContainsOnlyString("Screen")).thenReturn(true);

        //assert
        assertTrue(server.isInputContainsOnlyString("Screen"));
    }

    @Test
    void isInputContainsOnlyString_InputIsString_False() {
        //given
        Server server = mock(Server.class);

        //when
        when(server.isInputContainsOnlyString("Screen123")).thenReturn(false);

        //assert
        assertFalse(server.isInputContainsOnlyString("Screen123"));
    }


    @Test
    void isInputContainsOnlyDigit_InputIsString_True() {
        //given
        Server server = mock(Server.class);

        //when
        when(server.isInputContainsOnlyDigit("12341")).thenReturn(true);

        //assert
        assertTrue(server.isInputContainsOnlyDigit("12341"));
    }


    @Test
    void isInputContainsOnlyDigit_InputIsString_False() {
        //given
        Server server = mock(Server.class);

        //when
        when(server.isInputContainsOnlyDigit("12323ssdds23")).thenReturn(false);

        //assert
        assertFalse(server.isInputContainsOnlyDigit("12323ssdds23"));
    }

    @ParameterizedTest
    @DisplayName("Columns with String validation")
    @ValueSource(ints ={1,4,5,6,11,12,14,15})
    void isColumnWithStringValidation_InputIsInt_True(int column){
        //given
        Server server = mock(Server.class);

        //when
        when(server.isColumnWithStringValidation(column)).thenReturn(true);

        //assert
        assertTrue(server.isColumnWithStringValidation(column));
    }

    @ParameterizedTest
    @DisplayName("Columns without String validation")
    @ValueSource(ints = {0,2,3,7,8,9,10,11,13})
    void isColumnWithoutStringValidation_InputIsInt_False(int column) {
        //given
        Server server = mock(Server.class);

        //when
        when(server.isColumnWithStringValidation(column)).thenReturn(false);

        //assert
        assertFalse(server.isColumnWithStringValidation(column));
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

    @Test
    @DisplayName("Check if setting text not works on not empty String array")
    void shouldNotSetSpecifiedTextWhenInputDoesNotContainsEmptyValue() {
        String[] fields = new String[]{"test", "test 2", "test 3"};

        IntStream.range(0, fields.length)
                .filter(i -> fields[i].isEmpty())
                .forEach(i -> fields[i] = "Brak");

        assertAll("fields",
                () -> assertEquals("test", fields[0]),
                ()-> assertEquals("test 2", fields[1]),
                () -> assertEquals("test 3", fields[2]));
    }

    @Test
    @DisplayName("No set text when input is not empty")
    void shouldNoSetTextIfApplicable() {
        //given
        Server server = mock(Server.class);
        String input = "Test do wstawienia";

        //when
        when(server.setTextIfApplicable(input)).thenReturn(input);

        //assert
        assertEquals(input, server.setTextIfApplicable(input));
    }


    @Test
    @DisplayName("Set text when input is null")
    void shouldSetTextWhenInputIsNull(){
        //given
        Server server = mock(Server.class);

        //when
        when(server.setTextIfApplicable(null)).thenReturn("Brak");

        //then
        assertEquals("Brak", server.setTextIfApplicable(null));
    }

    @Test
    @DisplayName("Set text when input is empty")
    void shouldSetTextWhenInputIsEmpty() {
        //given
        Server server = mock(Server.class);

        //when
        when(server.setTextIfApplicable("")).thenReturn("Brak");

        //then
        assertEquals("Brak", server.setTextIfApplicable(""));
    }

}

import React from "react";
import {View, Text, Image, ScrollView, TextInput} from 'react-native';
import Cat from "./Cat";
import CatCaffe from "./CatCaffe";
import PizzaTranslator from "./Pizza";

const App = () => {
  return <ScrollView>
    {/* <Text> This is simple text which is displayed</Text>
    <View>
      <Text> Some more text</Text>
      <Image
          source={{
            uri: 'https://reactnative.dev/docs/assets/p_cat2.png',
          }}
          style={{width: 200, height: 200}}
        />
    </View>
    <TextInput 
    style={{
      height:40,
      borderColor: 'gray',
      borderWidth: 1,
    }}
    defaultValue= "You can type something here"
    />
    <Cat name="Johny"/>
    <Cat name="Matt"/> */}
    <CatCaffe/>
    <PizzaTranslator/>
  </ScrollView>
}

export default App;
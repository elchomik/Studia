import React from "react";
import {View, Text, Image, ScrollView, TextInput} from 'react-native';
import Cat from "./Cat";
import CatCaffe from "./CatCaffe";
import FixedDimensionsBasic from "./FixedDimensions";
import FlatListBasic from "./FlatListExample";
import Flex from "./Flex";
import FlexDirectionBasics from "./FlexDirectionBasics";
import NetworkApp from "./Networking";
import PizzaTranslator from "./Pizza";
import ScrollViewExample from "./ScrollViewExample";
import LotsOfStyle from "./StyleView";

const App = () => {
  //return <NetworkApp/>;
  // return <LotsOfStyle/>;
  //return <FixedDimensionsBasic/>;
  // return <Flex/>;
  return <FlexDirectionBasics/>;
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
    {/* <CatCaffe/>
    <PizzaTranslator/> */}

}

export default App;
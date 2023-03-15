import React from "react";
import { View } from "react-native";

const FixedDimensionsBasic = () => {
    return <View>
        <View style={{width: 50, height: 50, backgroundColor: 'powerblue'}}/>
        <View style={{width:100, height:100, backgroundColor: 'skyblue'}}/>
        <View style={{width:150, height:150, backgroundColor: 'steelblue'}}/>
    </View>
};

export default FixedDimensionsBasic;
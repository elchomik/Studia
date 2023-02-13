import React from "react";
import { Text, TextInput, View } from "react-native";

interface CatProps {
    name: string;
}

const Cat = (props: CatProps) => {
    return <View>
        <Text> Text, Hello I am {props.name}</Text>
        <TextInput
        style={{
            height: 40,
            borderColor: 'gray',
            borderWidth: 1,
        }}
        defaultValue = "Name me"
        />
    </View>
}

export default Cat;
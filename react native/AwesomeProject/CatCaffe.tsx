import React, {useState} from 'react';
import {Button, Text, View} from 'react-native';

type CatProps = {
    name:string;
};


const Cat = (props: CatProps) => {
    const {name} = props;
    const [isHungry, setIsHungry] = useState<boolean>(true);

    return <View>
        <Text> I am {name}, and I am {isHungry ? 'hungry' : 'full'} !</Text>
        <Button
        onPress={
            () => setIsHungry(false)
        }
        disabled = {!isHungry}
        title= {isHungry ? 'Pour me some milk, please!' : 'Thank you'}
        />
    </View>
};


const Cafe = () => {
    return <>
    <Cat name="Janek"/>
    <Cat name="Tomek"/>
    </>
};

export default Cafe;
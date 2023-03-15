import React from "react";
import {Image, ScrollView, Text} from 'react-native';

const logo = {
  uri: 'https://reactnative.dev/img/tiny_logo.png',
  width: 64,
  height: 64,
};

const ScrollViewExample = () => (
    <ScrollView>
        <Text style={{fontSize: 96}}>Scroll me please</Text>
        <Image source={logo}/>
        <Image source={logo}/>
        <Image source={logo}/>
        <Image source={logo}/>
        <Text style={{fontSize: 96}}>If you like me</Text>
        <Image source={logo}/>
        <Image source={logo}/>
        <Image source={logo}/>
        <Image source={logo}/>
        <Image source={logo}/>
        <Text style={{fontSize: 96}}>Scrolling down</Text>
        <Image source={logo}/>
        <Image source={logo}/>
        <Image source={logo}/>
        <Image source={logo}/>
        <Image source={logo}/>
        <Text style={{fontSize: 96}}>Framework around?</Text>
        <Image source={logo}/>
        <Image source={logo}/>
        <Image source={logo}/>
        <Image source={logo}/>
        <Image source={logo}/>
        <Text style={{fontSize: 80}}>React Native</Text>
   </ScrollView>
);

export default ScrollViewExample;
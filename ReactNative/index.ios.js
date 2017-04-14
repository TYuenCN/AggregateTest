'use strict';

import React from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Navigator,
  PixelRatio,
} from 'react-native';

class RNHighScores extends React.Component {
  render() {
    var contents = this.props["scores"].map(
      score => <Text key={score.name}>{score.name}:{score.value}{"\n"}</Text>
    );
    return (
      <View style={styles.container}>
        <Text style={styles.highScoresTitle}>
          2048 High Scores!\n{PixelRatio.get()}
        </Text>
        <Text style={styles.scores}>    
          {contents}
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },
  highScoresTitle: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  scores: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});


class MyTestNavi extends React.Component
{

  renderScene(route, navigator) {
    return <route.component navigator={navigator}  {...route.passProps} />;
  }
  render(){
    console.log(this.props);
    console.log(123123);
    return (<Navigator initialRoute={{name: 'shouYe', component:RNHighScores, passProps:this.props}}
                       renderScene={this.renderScene}/>);
  }
}

// 整体js模块的名称
AppRegistry.registerComponent('MyTestNavi', () => MyTestNavi);

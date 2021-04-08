<!DOCTYPE nsscheme>
<nsscheme type="sequence">
  <position>
    <x>4</x>
    <y>30</y>
  </position>
  <size>
    <width>843</width>
    <height>569</height>
  </size>
  <name>zadanie 3</name>
  <comment></comment>
  <author>Mateusz</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>rok</name>
      <type>
        <double/>
      </type>
      <value>6</value>
    </variable>
    <variable>
      <name>srednia</name>
      <type>
        <double/>
      </type>
      <value>5</value>
    </variable>
  </variables>
  <sequence>
    <outputinstruction>
      <text>'podaj rok studiow'</text>
      <comment></comment>
    </outputinstruction>
    <inputinstruction>
      <text>rok</text>
      <comment></comment>
    </inputinstruction>
    <selection instructionsheight="366" conditionheight="105">
      <condition>
        <text>rok>0</text>
        <comment></comment>
      </condition>
      <ontrue>
        <sequence>
          <selection instructionsheight="279" conditionheight="81">
            <condition>
              <text>rok&lt;=1</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <outputinstruction>
                  <text>'stypendium nie przysluguje'</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <selection instructionsheight="212" conditionheight="61">
                  <condition>
                    <text>rok&lt;=5</text>
                    <comment></comment>
                  </condition>
                  <ontrue>
                    <sequence>
                      <outputinstruction>
                        <text>'podaj srednia'</text>
                        <comment></comment>
                      </outputinstruction>
                      <inputinstruction>
                        <text>srednia</text>
                        <comment></comment>
                      </inputinstruction>
                      <selection instructionsheight="100" conditionheight="62">
                        <condition>
                          <text>srednia&lt;0 or srednia>5 or srednia&lt;4</text>
                          <comment></comment>
                        </condition>
                        <ontrue>
                          <sequence>
                            <outputinstruction>
                              <text>'nie poprawne dane'</text>
                              <comment></comment>
                            </outputinstruction>
                          </sequence>
                        </ontrue>
                        <onfalse>
                          <sequence>
                            <selection instructionsheight="61" conditionheight="33">
                              <condition>
                                <text>srednia>4 and srednia&lt;4.35</text>
                                <comment></comment>
                              </condition>
                              <ontrue>
                                <sequence>
                                  <outputinstruction>
                                    <text>'stypendium wynosi 220 zloty'</text>
                                    <comment></comment>
                                  </outputinstruction>
                                </sequence>
                              </ontrue>
                              <onfalse>
                                <sequence>
                                  <selection instructionsheight="22" conditionheight="33">
                                    <condition>
                                      <text>srednia>=4.7</text>
                                      <comment></comment>
                                    </condition>
                                    <ontrue>
                                      <sequence>
                                        <outputinstruction>
                                          <text>'stypednium wynosi 400 zloty'</text>
                                          <comment></comment>
                                        </outputinstruction>
                                      </sequence>
                                    </ontrue>
                                    <onfalse>
                                      <sequence>
                                        <outputinstruction>
                                          <text>'stypendium wynosi 300 zloty'</text>
                                          <comment></comment>
                                        </outputinstruction>
                                      </sequence>
                                    </onfalse>
                                  </selection>
                                </sequence>
                              </onfalse>
                            </selection>
                          </sequence>
                        </onfalse>
                      </selection>
                    </sequence>
                  </ontrue>
                  <onfalse>
                    <sequence>
                      <outputinstruction>
                        <text>'nie poprawne dane'</text>
                        <comment></comment>
                      </outputinstruction>
                    </sequence>
                  </onfalse>
                </selection>
              </sequence>
            </onfalse>
          </selection>
        </sequence>
      </ontrue>
      <onfalse>
        <sequence>
          <outputinstruction>
            <text>'nie poprawne dane'</text>
            <comment></comment>
          </outputinstruction>
        </sequence>
      </onfalse>
    </selection>
  </sequence>
</nsscheme>

<!DOCTYPE nsscheme>
<nsscheme type="sequence">
  <position>
    <x>4</x>
    <y>30</y>
  </position>
  <size>
    <width>240</width>
    <height>180</height>
  </size>
  <name>zadanie4-lepsze</name>
  <comment></comment>
  <author>Mateusz</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>x</name>
      <type>
        <double/>
      </type>
      <value>-7</value>
    </variable>
    <variable>
      <name>y</name>
      <type>
        <double/>
      </type>
      <value>-6</value>
    </variable>
  </variables>
  <sequence>
    <outputinstruction>
      <text>'podaj dwie dowolne liczby'</text>
      <comment></comment>
    </outputinstruction>
    <inputinstruction>
      <text>x, y</text>
      <comment></comment>
    </inputinstruction>
    <selection instructionsheight="65" conditionheight="33">
      <condition>
        <text>x=0</text>
        <comment></comment>
      </condition>
      <ontrue>
        <sequence>
          <selection instructionsheight="26" conditionheight="33">
            <condition>
              <text>y=0</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <outputinstruction>
                  <text>'punkt jest w srodku ukladu wspolrzednych'</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <outputinstruction>
                  <text>'punkt jest na osi OY'</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </onfalse>
          </selection>
        </sequence>
      </ontrue>
      <onfalse>
        <sequence>
          <selection instructionsheight="29" conditionheight="29">
            <condition>
              <text>y=0</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <outputinstruction>
                  <text>'punkt jest na osi OX'</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <selection instructionsheight="11" conditionheight="11">
                  <condition>
                    <text>x>0 and y>0</text>
                    <comment></comment>
                  </condition>
                  <ontrue>
                    <sequence>
                      <outputinstruction>
                        <text>'punkt jest w pierwszej cwiartce'</text>
                        <comment></comment>
                      </outputinstruction>
                    </sequence>
                  </ontrue>
                  <onfalse>
                    <sequence>
                      <selection instructionsheight="4" conditionheight="4">
                        <condition>
                          <text>x>0 and y&lt;0</text>
                          <comment></comment>
                        </condition>
                        <ontrue>
                          <sequence>
                            <outputinstruction>
                              <text>'punkt jest w czwartej cwiartce'</text>
                              <comment></comment>
                            </outputinstruction>
                          </sequence>
                        </ontrue>
                        <onfalse>
                          <sequence>
                            <selection instructionsheight="2" conditionheight="1">
                              <condition>
                                <text>x&lt;0 and y>0</text>
                                <comment></comment>
                              </condition>
                              <ontrue>
                                <sequence>
                                  <outputinstruction>
                                    <text>'punkt lezy w drugiej cwiartce'</text>
                                    <comment></comment>
                                  </outputinstruction>
                                </sequence>
                              </ontrue>
                              <onfalse>
                                <sequence>
                                  <outputinstruction>
                                    <text>'punkt jest w trzeciej cwiartce'</text>
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
            </onfalse>
          </selection>
        </sequence>
      </onfalse>
    </selection>
  </sequence>
</nsscheme>

<!DOCTYPE nsscheme>
<nsscheme type="sequence">
  <position>
    <x>4</x>
    <y>30</y>
  </position>
  <size>
    <width>1366</width>
    <height>621</height>
  </size>
  <name>sortowanie_liczb</name>
  <comment></comment>
  <author>mama</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>a</name>
      <type>
        <double/>
      </type>
      <value>1.33512e-306</value>
    </variable>
    <variable>
      <name>b</name>
      <type>
        <double/>
      </type>
      <value>2.3342e-313</value>
    </variable>
    <variable>
      <name>c</name>
      <type>
        <double/>
      </type>
      <value>2.3342e-313</value>
    </variable>
  </variables>
  <sequence>
    <outputinstruction>
      <text>'podaj 3 liczby do sprawdzenia'</text>
      <comment></comment>
    </outputinstruction>
    <inputinstruction>
      <text>a, b, c</text>
      <comment></comment>
    </inputinstruction>
    <selection instructionsheight="406" conditionheight="117">
      <condition>
        <text>a>b</text>
        <comment></comment>
      </condition>
      <ontrue>
        <sequence>
          <selection instructionsheight="367" conditionheight="33">
            <condition>
              <text>b>c</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <outputinstruction>
                  <text>a, b, c</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <selection instructionsheight="280" conditionheight="81">
                  <condition>
                    <text>a>c</text>
                    <comment></comment>
                  </condition>
                  <ontrue>
                    <sequence>
                      <outputinstruction>
                        <text>a, c, b</text>
                        <comment></comment>
                      </outputinstruction>
                    </sequence>
                  </ontrue>
                  <onfalse>
                    <sequence>
                      <outputinstruction>
                        <text>c, a, b</text>
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
          <selection instructionsheight="310" conditionheight="90">
            <condition>
              <text>a>c</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <outputinstruction>
                  <text>b, a, c</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <selection instructionsheight="236" conditionheight="68">
                  <condition>
                    <text>b>c</text>
                    <comment></comment>
                  </condition>
                  <ontrue>
                    <sequence>
                      <outputinstruction>
                        <text>b, c, a</text>
                        <comment></comment>
                      </outputinstruction>
                    </sequence>
                  </ontrue>
                  <onfalse>
                    <sequence>
                      <outputinstruction>
                        <text>c, b, a</text>
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
</nsscheme>

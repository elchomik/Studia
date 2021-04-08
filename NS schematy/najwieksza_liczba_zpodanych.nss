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
  <name>najwieksza_liczba_zpodanych</name>
  <comment></comment>
  <author>ma</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>a</name>
      <type>
        <double/>
      </type>
      <value>5</value>
    </variable>
    <variable>
      <name>b</name>
      <type>
        <double/>
      </type>
      <value>3</value>
    </variable>
    <variable>
      <name>c</name>
      <type>
        <double/>
      </type>
      <value>1</value>
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
          <selection instructionsheight="310" conditionheight="90">
            <condition>
              <text>a>c</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <outputinstruction>
                  <text>'najwieksza liczba z podanych to', a</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <outputinstruction>
                  <text>'najwieksza liczba z podanych to', c</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </onfalse>
          </selection>
        </sequence>
      </ontrue>
      <onfalse>
        <sequence>
          <selection instructionsheight="310" conditionheight="90">
            <condition>
              <text>b>c</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <outputinstruction>
                  <text>'najwieksza liczba z podanych to', b</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <outputinstruction>
                  <text>'najwieksza liczba z podanych to', c</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </onfalse>
          </selection>
        </sequence>
      </onfalse>
    </selection>
  </sequence>
</nsscheme>

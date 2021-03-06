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
  <name>Zadanie3b</name>
  <comment></comment>
  <author>M.M</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>P</name>
      <type>
        <double/>
      </type>
      <value>0.993103</value>
    </variable>
    <variable>
      <name>d</name>
      <type>
        <double/>
      </type>
      <value>-9</value>
    </variable>
    <variable>
      <name>i</name>
      <type>
        <double/>
      </type>
      <value>4</value>
    </variable>
    <variable>
      <name>iloczynx</name>
      <type>
        <double/>
      </type>
      <value>48</value>
    </variable>
    <variable>
      <name>n</name>
      <type>
        <double/>
      </type>
      <value>-9</value>
    </variable>
    <variable>
      <name>sumaxn</name>
      <type>
        <double/>
      </type>
      <value>144</value>
    </variable>
    <variable>
      <name>x</name>
      <type>
        <double/>
      </type>
      <value>6</value>
    </variable>
  </variables>
  <sequence>
    <outputinstruction>
      <text>'Podaj ilosc elementow ciagu'</text>
      <comment></comment>
    </outputinstruction>
    <inputinstruction>
      <text>n</text>
      <comment></comment>
    </inputinstruction>
    <simpleinstruction>
      <text>d:=n div 1</text>
      <comment></comment>
    </simpleinstruction>
    <selection instructionsheight="389" conditionheight="112">
      <condition>
        <text>d=0 and n>0</text>
        <comment></comment>
      </condition>
      <ontrue>
        <sequence>
          <simpleinstruction>
            <text>iloczynx:=1</text>
            <comment></comment>
          </simpleinstruction>
          <simpleinstruction>
            <text>sumaxn:=0</text>
            <comment></comment>
          </simpleinstruction>
          <simpleinstruction>
            <text>i:=1</text>
            <comment></comment>
          </simpleinstruction>
          <iteration>
            <condition>
              <text>i&lt;=n</text>
              <comment></comment>
            </condition>
            <loop>
              <sequence>
                <outputinstruction>
                  <text>'Podaj  x', i, '='</text>
                  <comment></comment>
                </outputinstruction>
                <inputinstruction>
                  <text>x</text>
                  <comment></comment>
                </inputinstruction>
                <simpleinstruction>
                  <text>iloczynx:=iloczynx*abs(x)</text>
                  <comment></comment>
                </simpleinstruction>
                <simpleinstruction>
                  <text>sumaxn:=sumaxn+i*x*x</text>
                  <comment></comment>
                </simpleinstruction>
                <simpleinstruction>
                  <text>i:=i+1</text>
                  <comment></comment>
                </simpleinstruction>
              </sequence>
            </loop>
          </iteration>
          <simpleinstruction>
            <text>P:=(3*iloczynx)/(sumaxn+1)</text>
            <comment></comment>
          </simpleinstruction>
          <outputinstruction>
            <text>'Wynik to', P</text>
            <comment></comment>
          </outputinstruction>
        </sequence>
      </ontrue>
      <onfalse>
        <sequence>
          <outputinstruction>
            <text>'Podales zle dane, aby obliczyc podane wyrazenie'</text>
            <comment></comment>
          </outputinstruction>
        </sequence>
      </onfalse>
    </selection>
  </sequence>
</nsscheme>

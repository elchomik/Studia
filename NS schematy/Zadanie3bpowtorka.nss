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
  <name>Zadanie3bpowtorka</name>
  <comment></comment>
  <author>mgmf</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>Wynik</name>
      <type>
        <double/>
      </type>
      <value>1.51256e-289</value>
    </variable>
    <variable>
      <name>d</name>
      <type>
        <double/>
      </type>
      <value>3</value>
    </variable>
    <variable>
      <name>i</name>
      <type>
        <double/>
      </type>
      <value>1</value>
    </variable>
    <variable>
      <name>iloczynx1</name>
      <type>
        <double/>
      </type>
      <value>2</value>
    </variable>
    <variable>
      <name>n</name>
      <type>
        <double/>
      </type>
      <value>3</value>
    </variable>
    <variable>
      <name>sumax</name>
      <type>
        <double/>
      </type>
      <value>4</value>
    </variable>
    <variable>
      <name>x</name>
      <type>
        <double/>
      </type>
      <value>0</value>
    </variable>
  </variables>
  <sequence>
    <outputinstruction>
      <text>'podaj ilosc elementow ciagu'</text>
      <comment></comment>
    </outputinstruction>
    <inputinstruction>
      <text>n</text>
      <comment></comment>
    </inputinstruction>
    <selection instructionsheight="406" conditionheight="117">
      <condition>
        <text> n>0</text>
        <comment></comment>
      </condition>
      <ontrue>
        <sequence>
          <simpleinstruction>
            <text>iloczynx1:=1</text>
            <comment></comment>
          </simpleinstruction>
          <simpleinstruction>
            <text>sumax:=0</text>
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
                  <text>'podaj x', i, '='</text>
                  <comment></comment>
                </outputinstruction>
                <inputinstruction>
                  <text>x</text>
                  <comment></comment>
                </inputinstruction>
                <simpleinstruction>
                  <text>iloczynx1:=iloczynx1*abs(x)</text>
                  <comment></comment>
                </simpleinstruction>
                <simpleinstruction>
                  <text>sumax:=sumax+i*x*x</text>
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
            <text>Wynik:=(3*iloczynx1)/sumax</text>
            <comment></comment>
          </simpleinstruction>
          <outputinstruction>
            <text>'Wynik to', Wynik</text>
            <comment></comment>
          </outputinstruction>
        </sequence>
      </ontrue>
      <onfalse>
        <sequence/>
      </onfalse>
    </selection>
  </sequence>
</nsscheme>

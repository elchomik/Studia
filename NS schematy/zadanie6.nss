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
  <name>zadanie6</name>
  <comment></comment>
  <author>Mateusz</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>C1</name>
      <type>
        <double/>
      </type>
      <value>1365</value>
    </variable>
    <variable>
      <name>C2</name>
      <type>
        <double/>
      </type>
      <value>1380</value>
    </variable>
    <variable>
      <name>Czas</name>
      <type>
        <double/>
      </type>
      <value>540</value>
    </variable>
    <variable>
      <name>czas</name>
      <type>
        <double/>
      </type>
      <value>15</value>
    </variable>
    <variable>
      <name>g1</name>
      <type>
        <double/>
      </type>
      <value>22</value>
    </variable>
    <variable>
      <name>g2</name>
      <type>
        <double/>
      </type>
      <value>23</value>
    </variable>
    <variable>
      <name>godzin</name>
      <type>
        <double/>
      </type>
      <value>15</value>
    </variable>
    <variable>
      <name>m1</name>
      <type>
        <double/>
      </type>
      <value>45</value>
    </variable>
    <variable>
      <name>m2</name>
      <type>
        <double/>
      </type>
      <value>0</value>
    </variable>
    <variable>
      <name>minut</name>
      <type>
        <double/>
      </type>
      <value>0</value>
    </variable>
    <variable>
      <name>wynik</name>
      <type>
        <double/>
      </type>
      <value>0</value>
    </variable>
  </variables>
  <sequence>
    <outputinstruction>
      <text>'podaj pierwsze  godzine i minuty'</text>
      <comment></comment>
    </outputinstruction>
    <inputinstruction>
      <text>g1, m1</text>
      <comment></comment>
    </inputinstruction>
    <outputinstruction>
      <text>'podaj drugie godziny i minuty'</text>
      <comment></comment>
    </outputinstruction>
    <inputinstruction>
      <text>g2, m2</text>
      <comment></comment>
    </inputinstruction>
    <selection instructionsheight="372" conditionheight="107">
      <condition>
        <text>g1>=0 and g1&lt;=23 and m1>=0 and m1&lt;=59 and g2>=0 and g2&lt;=23 and m2>=0 and m2&lt;=59</text>
        <comment></comment>
      </condition>
      <ontrue>
        <sequence>
          <simpleinstruction>
            <text>C1:=(g1*60)+m1</text>
            <comment></comment>
          </simpleinstruction>
          <simpleinstruction>
            <text>C2:=(g2*60)+m2</text>
            <comment></comment>
          </simpleinstruction>
          <selection instructionsheight="250" conditionheight="72">
            <condition>
              <text>C2&lt;C1</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <simpleinstruction>
                  <text>C2:=C2+1440</text>
                  <comment></comment>
                </simpleinstruction>
                <simpleinstruction>
                  <text>czas:=C2-C1</text>
                  <comment></comment>
                </simpleinstruction>
                <outputinstruction>
                  <text>'czas', czas</text>
                  <comment></comment>
                </outputinstruction>
                <simpleinstruction>
                  <text>godzin:=czas div 60</text>
                  <comment></comment>
                </simpleinstruction>
                <simpleinstruction>
                  <text>minut:=czas mod 60</text>
                  <comment></comment>
                </simpleinstruction>
                <outputinstruction>
                  <text>'wynik', godzin, minut</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <simpleinstruction>
                  <text>czas:=C2-C1</text>
                  <comment></comment>
                </simpleinstruction>
                <outputinstruction>
                  <text>'czas to:', czas</text>
                  <comment></comment>
                </outputinstruction>
                <simpleinstruction>
                  <text>godzin:=czas div 60</text>
                  <comment></comment>
                </simpleinstruction>
                <simpleinstruction>
                  <text>minut:= czas mod 60</text>
                  <comment></comment>
                </simpleinstruction>
                <outputinstruction>
                  <text>'wynik', godzin, minut</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </onfalse>
          </selection>
        </sequence>
      </ontrue>
      <onfalse>
        <sequence>
          <outputinstruction>
            <text>'podales nie poprawne dane'</text>
            <comment></comment>
          </outputinstruction>
        </sequence>
      </onfalse>
    </selection>
  </sequence>
</nsscheme>

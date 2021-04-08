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
  <name>dat,miesiac,rok</name>
  <comment></comment>
  <author>Mateusz</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>d</name>
      <type>
        <double/>
      </type>
      <value>25</value>
    </variable>
    <variable>
      <name>ld</name>
      <type>
        <double/>
      </type>
      <value>31</value>
    </variable>
    <variable>
      <name>m</name>
      <type>
        <double/>
      </type>
      <value>3</value>
    </variable>
    <variable>
      <name>r</name>
      <type>
        <double/>
      </type>
      <value>1600</value>
    </variable>
    <variable>
      <name>rok</name>
      <type>
        <double/>
      </type>
      <value>4.46416e+192</value>
    </variable>
  </variables>
  <sequence>
    <outputinstruction>
      <text>'Podaj miesiac dzien i rok'</text>
      <comment></comment>
    </outputinstruction>
    <inputinstruction>
      <text>d, m, r</text>
      <comment></comment>
    </inputinstruction>
    <selection instructionsheight="490" conditionheight="33">
      <condition>
        <text>m=2</text>
        <comment></comment>
      </condition>
      <ontrue>
        <sequence>
          <selection instructionsheight="376" conditionheight="108">
            <condition>
              <text>(rok mod 400=0) or ( rok mod 4=0) and (rok mod 100&lt;>0) </text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <simpleinstruction>
                  <text>ld:=29</text>
                  <comment></comment>
                </simpleinstruction>
                <outputinstruction>
                  <text>'Data poprawna', d, m, r</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <simpleinstruction>
                  <text>ld:=28</text>
                  <comment></comment>
                </simpleinstruction>
                <outputinstruction>
                  <text>'Data poprawna', d, m, r</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </onfalse>
          </selection>
        </sequence>
      </ontrue>
      <onfalse>
        <sequence>
          <selection instructionsheight="185" conditionheight="54">
            <condition>
              <text>m=4 or m=6 or m=9 or m=11</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <simpleinstruction>
                  <text>ld:=30</text>
                  <comment></comment>
                </simpleinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <simpleinstruction>
                  <text>ld:=31</text>
                  <comment></comment>
                </simpleinstruction>
              </sequence>
            </onfalse>
          </selection>
          <selection instructionsheight="185" conditionheight="54">
            <condition>
              <text>m>1 and m&lt;12 and d>1 and d&lt;ld</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <outputinstruction>
                  <text>'Data poprawna', d, m, r</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <outputinstruction>
                  <text>'Data  nie poprawna'</text>
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

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
  <name>Wyznaczniki</name>
  <comment></comment>
  <author>wqdq</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>W</name>
      <type>
        <double/>
      </type>
      <value>-6</value>
    </variable>
    <variable>
      <name>Wx</name>
      <type>
        <double/>
      </type>
      <value>51</value>
    </variable>
    <variable>
      <name>Wy</name>
      <type>
        <double/>
      </type>
      <value>-48</value>
    </variable>
    <variable>
      <name>a</name>
      <type>
        <double/>
      </type>
      <value>2</value>
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
      <value>7</value>
    </variable>
    <variable>
      <name>d</name>
      <type>
        <double/>
      </type>
      <value>8</value>
    </variable>
    <variable>
      <name>e</name>
      <type>
        <double/>
      </type>
      <value>9</value>
    </variable>
    <variable>
      <name>f</name>
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
      <value>-8.5</value>
    </variable>
    <variable>
      <name>y</name>
      <type>
        <double/>
      </type>
      <value>8</value>
    </variable>
  </variables>
  <sequence>
    <outputinstruction>
      <text>'podaj parametry wyznacznikow'</text>
      <comment></comment>
    </outputinstruction>
    <inputinstruction>
      <text>a, b, c, d, e, f</text>
      <comment></comment>
    </inputinstruction>
    <simpleinstruction>
      <text>W:=wyznacznik(a, b, d, e)</text>
      <comment></comment>
    </simpleinstruction>
    <simpleinstruction>
      <text>Wx:=wyznacznik(c, b, f, e)</text>
      <comment></comment>
    </simpleinstruction>
    <simpleinstruction>
      <text>Wy:=wyznacznik(a, c, d, f)</text>
      <comment></comment>
    </simpleinstruction>
    <selection instructionsheight="355" conditionheight="102">
      <condition>
        <text>W&lt;>0</text>
        <comment></comment>
      </condition>
      <ontrue>
        <sequence>
          <simpleinstruction>
            <text>x:=Wx/W</text>
            <comment></comment>
          </simpleinstruction>
          <simpleinstruction>
            <text>y:=Wy/W</text>
            <comment></comment>
          </simpleinstruction>
          <outputinstruction>
            <text>'Uklad jest oznaczony', x, y</text>
            <comment></comment>
          </outputinstruction>
        </sequence>
      </ontrue>
      <onfalse>
        <sequence>
          <selection instructionsheight="271" conditionheight="78">
            <condition>
              <text>Wx=0 and Wy=0</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <outputinstruction>
                  <text>'Uklad jest oznaczony spelnia go kazda liczba'</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <outputinstruction>
                  <text>'Uklad jest sprzeczny'</text>
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

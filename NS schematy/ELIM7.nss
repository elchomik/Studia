<!DOCTYPE nsscheme>
<nsscheme type="procedure">
  <position>
    <x>4</x>
    <y>30</y>
  </position>
  <size>
    <width>240</width>
    <height>331</height>
  </size>
  <name>ELIM7(n,a)</name>
  <comment></comment>
  <author>m</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>a</name>
      <type>
        <array size="10" dims="10">
          <long/>
        </array>
      </type>
      <value>
        <element>0</element>
        <element>0</element>
        <element>0</element>
        <element>0</element>
        <element>0</element>
        <element>0</element>
        <element>0</element>
        <element>0</element>
        <element>0</element>
        <element>0</element>
      </value>
    </variable>
    <variable>
      <name>i</name>
      <type>
        <double/>
      </type>
      <value>9.08367e+223</value>
    </variable>
    <variable>
      <name>n</name>
      <type>
        <double/>
      </type>
      <value>7.56604e-307</value>
    </variable>
    <variable>
      <name>n2</name>
      <type>
        <double/>
      </type>
      <value>1.42418e-306</value>
    </variable>
  </variables>
  <sequence>
    <inputinstruction>
      <text>n</text>
      <comment></comment>
    </inputinstruction>
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
          <inputinstruction>
            <text>a[i]</text>
            <comment></comment>
          </inputinstruction>
          <simpleinstruction>
            <text>i:=i+1</text>
            <comment></comment>
          </simpleinstruction>
        </sequence>
      </loop>
    </iteration>
    <simpleinstruction>
      <text>i:=1</text>
      <comment></comment>
    </simpleinstruction>
    <simpleinstruction>
      <text>n2:=n</text>
      <comment></comment>
    </simpleinstruction>
    <iteration>
      <condition>
        <text>i&lt;=n</text>
        <comment></comment>
      </condition>
      <loop>
        <sequence>
          <selection instructionsheight="43" conditionheight="33">
            <condition>
              <text>a[i] mod 7=0</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <simpleinstruction>
                  <text>a[i]:=a[i+1]</text>
                  <comment></comment>
                </simpleinstruction>
                <simpleinstruction>
                  <text>n2:=n2-1</text>
                  <comment></comment>
                </simpleinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence/>
            </onfalse>
          </selection>
          <simpleinstruction>
            <text>i:=i+1</text>
            <comment></comment>
          </simpleinstruction>
        </sequence>
      </loop>
    </iteration>
    <outputinstruction>
      <text>n2</text>
      <comment></comment>
    </outputinstruction>
  </sequence>
</nsscheme>

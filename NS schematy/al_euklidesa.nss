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
  <name>al_euklidesa</name>
  <comment></comment>
  <author>a</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>m</name>
      <type>
        <double/>
      </type>
      <value>1.59495e+06</value>
    </variable>
    <variable>
      <name>n</name>
      <type>
        <double/>
      </type>
      <value>1.59495e+06</value>
    </variable>
    <variable>
      <name>r</name>
      <type>
        <double/>
      </type>
      <value>-1.21152e+10</value>
    </variable>
  </variables>
  <sequence>
    <inputinstruction>
      <text>n, m</text>
      <comment></comment>
    </inputinstruction>
    <iteration>
      <condition>
        <text>m&lt;>0</text>
        <comment></comment>
      </condition>
      <loop>
        <sequence>
          <simpleinstruction>
            <text>r:=n-(n mod m)*m</text>
            <comment></comment>
          </simpleinstruction>
          <simpleinstruction>
            <text>n:=m</text>
            <comment></comment>
          </simpleinstruction>
          <simpleinstruction>
            <text>m:=r</text>
            <comment></comment>
          </simpleinstruction>
        </sequence>
      </loop>
    </iteration>
    <outputinstruction>
      <text>'NWD=', n</text>
      <comment></comment>
    </outputinstruction>
  </sequence>
</nsscheme>

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
  <name>projekt 1</name>
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
      <value>6.42925e-298</value>
    </variable>
    <variable>
      <name>a</name>
      <type>
        <double/>
      </type>
      <value>2.3342e-313</value>
    </variable>
    <variable>
      <name>b</name>
      <type>
        <double/>
      </type>
      <value>8.9007e-308</value>
    </variable>
    <variable>
      <name>c</name>
      <type>
        <double/>
      </type>
      <value>1.33512e-306</value>
    </variable>
    <variable>
      <name>l</name>
      <type>
        <double/>
      </type>
      <value>1.6022e-306</value>
    </variable>
    <variable>
      <name>p</name>
      <type>
        <double/>
      </type>
      <value>2.3342e-313</value>
    </variable>
  </variables>
  <sequence>
    <outputinstruction>
      <text>' podaj trzy liczby '</text>
      <comment></comment>
    </outputinstruction>
    <inputinstruction>
      <text>a, b, c</text>
      <comment></comment>
    </inputinstruction>
    <simpleinstruction>
      <text>l:=a+b+c</text>
      <comment></comment>
    </simpleinstruction>
    <simpleinstruction>
      <text>p:=l/2</text>
      <comment></comment>
    </simpleinstruction>
    <simpleinstruction>
      <text>P:=sqrt(p*(p-a)*(p-b)*(p-c))</text>
      <comment></comment>
    </simpleinstruction>
    <outputinstruction>
      <text>l, p</text>
      <comment></comment>
    </outputinstruction>
  </sequence>
</nsscheme>

<!DOCTYPE nsscheme>
<nsscheme type="sequence">
  <position>
    <x>4</x>
    <y>30</y>
  </position>
  <size>
    <width>278</width>
    <height>820</height>
  </size>
  <name>najkrotsza_droga</name>
  <comment></comment>
  <author>m</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>d</name>
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
      <value>1.6022e-306</value>
    </variable>
    <variable>
      <name>indeks</name>
      <type>
        <double/>
      </type>
      <value>3.4053e-305</value>
    </variable>
    <variable>
      <name>j</name>
      <type>
        <double/>
      </type>
      <value>2.3342e-313</value>
    </variable>
    <variable>
      <name>k</name>
      <type>
        <double/>
      </type>
      <value>1.6022e-306</value>
    </variable>
    <variable>
      <name>min</name>
      <type>
        <double/>
      </type>
      <value>2.3342e-313</value>
    </variable>
    <variable>
      <name>odleglosc</name>
      <type>
        <double/>
      </type>
      <value>0</value>
    </variable>
    <variable>
      <name>s</name>
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
  </variables>
  <sequence>
    <inputinstruction>
      <text>k</text>
      <comment></comment>
    </inputinstruction>
    <simpleinstruction>
      <text>i:=1</text>
      <comment></comment>
    </simpleinstruction>
    <iteration>
      <condition>
        <text>i&lt;=k</text>
        <comment></comment>
      </condition>
      <loop>
        <sequence>
          <inputinstruction>
            <text>d[i]</text>
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
      <text>odleglosc:=1</text>
      <comment></comment>
    </simpleinstruction>
    <simpleinstruction>
      <text>min:=0</text>
      <comment></comment>
    </simpleinstruction>
    <simpleinstruction>
      <text>indeks:=0</text>
      <comment></comment>
    </simpleinstruction>
    <iteration>
      <condition>
        <text>i&lt;=k</text>
        <comment></comment>
      </condition>
      <loop>
        <sequence>
          <simpleinstruction>
            <text>j:=1</text>
            <comment></comment>
          </simpleinstruction>
          <simpleinstruction>
            <text>s[i]:=0</text>
            <comment></comment>
          </simpleinstruction>
          <iteration>
            <condition>
              <text>j&lt;=k</text>
              <comment></comment>
            </condition>
            <loop>
              <sequence>
                <simpleinstruction>
                  <text>odleglosc:=d[i]-d[j]</text>
                  <comment></comment>
                </simpleinstruction>
                <selection instructionsheight="22" conditionheight="33">
                  <condition>
                    <text>odleglosc&lt;0</text>
                    <comment></comment>
                  </condition>
                  <ontrue>
                    <sequence>
                      <simpleinstruction>
                        <text>odleglosc:=odleglosc*(-1)</text>
                        <comment></comment>
                      </simpleinstruction>
                    </sequence>
                  </ontrue>
                  <onfalse>
                    <sequence/>
                  </onfalse>
                </selection>
                <simpleinstruction>
                  <text>s[i]:=s[i]+odleglosc</text>
                  <comment></comment>
                </simpleinstruction>
                <simpleinstruction>
                  <text>j:=j+1</text>
                  <comment></comment>
                </simpleinstruction>
              </sequence>
            </loop>
          </iteration>
          <selection instructionsheight="77" conditionheight="33">
            <condition>
              <text>i=1</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <simpleinstruction>
                  <text>min:=s[i]</text>
                  <comment></comment>
                </simpleinstruction>
                <simpleinstruction>
                  <text>indeks:=i</text>
                  <comment></comment>
                </simpleinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <selection instructionsheight="38" conditionheight="33">
                  <condition>
                    <text>s[i]&lt;min</text>
                    <comment></comment>
                  </condition>
                  <ontrue>
                    <sequence>
                      <simpleinstruction>
                        <text>min:=s[i]</text>
                        <comment></comment>
                      </simpleinstruction>
                      <simpleinstruction>
                        <text>indeks:=i</text>
                        <comment></comment>
                      </simpleinstruction>
                    </sequence>
                  </ontrue>
                  <onfalse>
                    <sequence/>
                  </onfalse>
                </selection>
              </sequence>
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
      <text>indeks</text>
      <comment></comment>
    </outputinstruction>
  </sequence>
</nsscheme>

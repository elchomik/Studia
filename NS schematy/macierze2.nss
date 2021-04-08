<!DOCTYPE nsscheme>
<nsscheme type="sequence">
  <position>
    <x>4</x>
    <y>30</y>
  </position>
  <size>
    <width>382</width>
    <height>673</height>
  </size>
  <name>macierze2</name>
  <comment></comment>
  <author>sd</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>A</name>
      <type>
        <array size="100" dims="10,10">
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
      <value>2.3342e-313</value>
    </variable>
    <variable>
      <name>j</name>
      <type>
        <double/>
      </type>
      <value>3.6905e-298</value>
    </variable>
    <variable>
      <name>k</name>
      <type>
        <double/>
      </type>
      <value>7.56604e-307</value>
    </variable>
    <variable>
      <name>kmax</name>
      <type>
        <double/>
      </type>
      <value>4.84422e-298</value>
    </variable>
    <variable>
      <name>kmin</name>
      <type>
        <double/>
      </type>
      <value>3.6905e-298</value>
    </variable>
    <variable>
      <name>max1</name>
      <type>
        <double/>
      </type>
      <value>4.84422e-298</value>
    </variable>
    <variable>
      <name>min</name>
      <type>
        <double/>
      </type>
      <value>1.6022e-306</value>
    </variable>
    <variable>
      <name>pom</name>
      <type>
        <double/>
      </type>
      <value>1.6022e-306</value>
    </variable>
    <variable>
      <name>w</name>
      <type>
        <double/>
      </type>
      <value>8.9007e-308</value>
    </variable>
  </variables>
  <sequence>
    <outputinstruction>
      <text>'podaj wiersze'</text>
      <comment></comment>
    </outputinstruction>
    <inputinstruction>
      <text>w</text>
      <comment></comment>
    </inputinstruction>
    <outputinstruction>
      <text>'podaj kolumny'</text>
      <comment></comment>
    </outputinstruction>
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
        <text>i&lt;=w</text>
        <comment></comment>
      </condition>
      <loop>
        <sequence>
          <simpleinstruction>
            <text>j:=1</text>
            <comment></comment>
          </simpleinstruction>
          <iteration>
            <condition>
              <text>j&lt;=k</text>
              <comment></comment>
            </condition>
            <loop>
              <sequence>
                <outputinstruction>
                  <text>'wczytaj elementy do macierzy'</text>
                  <comment></comment>
                </outputinstruction>
                <inputinstruction>
                  <text>A[i, j]</text>
                  <comment></comment>
                </inputinstruction>
                <simpleinstruction>
                  <text>j:=j+1</text>
                  <comment></comment>
                </simpleinstruction>
              </sequence>
            </loop>
          </iteration>
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
      <text>max1:=A[1, 1]</text>
      <comment></comment>
    </simpleinstruction>
    <simpleinstruction>
      <text>min:=max1</text>
      <comment></comment>
    </simpleinstruction>
    <iteration>
      <condition>
        <text>i&lt;=w</text>
        <comment></comment>
      </condition>
      <loop>
        <sequence>
          <simpleinstruction>
            <text>j:=1</text>
            <comment></comment>
          </simpleinstruction>
          <iteration>
            <condition>
              <text>j&lt;=k</text>
              <comment></comment>
            </condition>
            <loop>
              <sequence>
                <selection instructionsheight="91" conditionheight="33">
                  <condition>
                    <text>A[i, j]>max1</text>
                    <comment></comment>
                  </condition>
                  <ontrue>
                    <sequence>
                      <simpleinstruction>
                        <text>max1:=A[i, j]</text>
                        <comment></comment>
                      </simpleinstruction>
                      <simpleinstruction>
                        <text>kmax:=j</text>
                        <comment></comment>
                      </simpleinstruction>
                      <simpleinstruction>
                        <text>j:=j+1</text>
                        <comment></comment>
                      </simpleinstruction>
                    </sequence>
                  </ontrue>
                  <onfalse>
                    <sequence>
                      <selection instructionsheight="52" conditionheight="33">
                        <condition>
                          <text>A[i, j]&lt;min</text>
                          <comment></comment>
                        </condition>
                        <ontrue>
                          <sequence>
                            <simpleinstruction>
                              <text>min:=A[i, j]</text>
                              <comment></comment>
                            </simpleinstruction>
                            <simpleinstruction>
                              <text>kmin:=j</text>
                              <comment></comment>
                            </simpleinstruction>
                            <simpleinstruction>
                              <text>j:=j+1</text>
                              <comment></comment>
                            </simpleinstruction>
                          </sequence>
                        </ontrue>
                        <onfalse>
                          <sequence>
                            <simpleinstruction>
                              <text>j:=j+1</text>
                              <comment></comment>
                            </simpleinstruction>
                          </sequence>
                        </onfalse>
                      </selection>
                    </sequence>
                  </onfalse>
                </selection>
              </sequence>
            </loop>
          </iteration>
          <simpleinstruction>
            <text>i:=i+1</text>
            <comment></comment>
          </simpleinstruction>
        </sequence>
      </loop>
    </iteration>
    <selection instructionsheight="118" conditionheight="33">
      <condition>
        <text>max1&lt;>min</text>
        <comment></comment>
      </condition>
      <ontrue>
        <sequence>
          <simpleinstruction>
            <text>i:=1</text>
            <comment></comment>
          </simpleinstruction>
          <iteration>
            <condition>
              <text>i&lt;=w</text>
              <comment></comment>
            </condition>
            <loop>
              <sequence>
                <simpleinstruction>
                  <text>pom:=A[i, kmin]</text>
                  <comment></comment>
                </simpleinstruction>
                <simpleinstruction>
                  <text>A[i, kmin]:=A[i, kmax]</text>
                  <comment></comment>
                </simpleinstruction>
                <simpleinstruction>
                  <text>A[i, kmax]:=pom</text>
                  <comment></comment>
                </simpleinstruction>
                <simpleinstruction>
                  <text>i:=i+1</text>
                  <comment></comment>
                </simpleinstruction>
              </sequence>
            </loop>
          </iteration>
        </sequence>
      </ontrue>
      <onfalse>
        <sequence>
          <outputinstruction>
            <text>'nie zamieniaj'</text>
            <comment></comment>
          </outputinstruction>
        </sequence>
      </onfalse>
    </selection>
  </sequence>
</nsscheme>

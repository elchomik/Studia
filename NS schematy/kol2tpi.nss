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
  <name>kol2tpi</name>
  <comment></comment>
  <author>MM</author>
  <pascalCode contains="yes"/>
  <checkSyntax enabled="yes"/>
  <variables>
    <variable>
      <name>k</name>
      <type>
        <double/>
      </type>
      <value>6</value>
    </variable>
    <variable>
      <name>r</name>
      <type>
        <double/>
      </type>
      <value>-0.653644</value>
    </variable>
    <variable>
      <name>t</name>
      <type>
        <double/>
      </type>
      <value>4</value>
    </variable>
  </variables>
  <sequence>
    <outputinstruction>
      <text>'podaj liczbe rzeczywista t'</text>
      <comment></comment>
    </outputinstruction>
    <inputinstruction>
      <text>t</text>
      <comment></comment>
    </inputinstruction>
    <outputinstruction>
      <text>'podaj liczbe calkowita k'</text>
      <comment></comment>
    </outputinstruction>
    <inputinstruction>
      <text>k</text>
      <comment></comment>
    </inputinstruction>
    <selection instructionsheight="37" conditionheight="33">
      <condition>
        <text>k>=0</text>
        <comment></comment>
      </condition>
      <ontrue>
        <sequence>
          <selection instructionsheight="15" conditionheight="15">
            <condition>
              <text>k mod 4=0</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <simpleinstruction>
                  <text>r:=sin(t)</text>
                  <comment></comment>
                </simpleinstruction>
                <outputinstruction>
                  <text>'sin[', k, ']=sin(', t, ')'</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <selection instructionsheight="5" conditionheight="5">
                  <condition>
                    <text>k mod 3=0</text>
                    <comment></comment>
                  </condition>
                  <ontrue>
                    <sequence>
                      <simpleinstruction>
                        <text>r:=cos(t)</text>
                        <comment></comment>
                      </simpleinstruction>
                      <outputinstruction>
                        <text>'sin[', k, ']=sin(', t, ')'</text>
                        <comment></comment>
                      </outputinstruction>
                    </sequence>
                  </ontrue>
                  <onfalse>
                    <sequence>
                      <selection instructionsheight="2" conditionheight="2">
                        <condition>
                          <text>k mod 2=0</text>
                          <comment></comment>
                        </condition>
                        <ontrue>
                          <sequence>
                            <simpleinstruction>
                              <text>r:=-sin(t)</text>
                              <comment></comment>
                            </simpleinstruction>
                            <outputinstruction>
                              <text>'sin[', k, ']=sin(', t, ')'</text>
                              <comment></comment>
                            </outputinstruction>
                          </sequence>
                        </ontrue>
                        <onfalse>
                          <sequence>
                            <simpleinstruction>
                              <text>r:=-cos(t)</text>
                              <comment></comment>
                            </simpleinstruction>
                            <outputinstruction>
                              <text>'sin[', k, ']=sin(', t, ')'</text>
                              <comment></comment>
                            </outputinstruction>
                          </sequence>
                        </onfalse>
                      </selection>
                    </sequence>
                  </onfalse>
                </selection>
              </sequence>
            </onfalse>
          </selection>
        </sequence>
      </ontrue>
      <onfalse>
        <sequence>
          <outputinstruction>
            <text>'podaels zle dane'</text>
            <comment></comment>
          </outputinstruction>
        </sequence>
      </onfalse>
    </selection>
  </sequence>
</nsscheme>

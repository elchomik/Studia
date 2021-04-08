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
  <name>zadanie4</name>
  <comment></comment>
  <author>mk</author>
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
        <element>5</element>
        <element>5</element>
        <element>6</element>
        <element>90</element>
        <element>32</element>
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
      <value>1</value>
    </variable>
    <variable>
      <name>max1</name>
      <type>
        <double/>
      </type>
      <value>5</value>
    </variable>
    <variable>
      <name>max2</name>
      <type>
        <double/>
      </type>
      <value>2.49748e-306</value>
    </variable>
    <variable>
      <name>n</name>
      <type>
        <double/>
      </type>
      <value>5</value>
    </variable>
    <variable>
      <name>sa2</name>
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
        <text>n>0</text>
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
            <text>max1:=a[1]</text>
            <comment></comment>
          </simpleinstruction>
          <simpleinstruction>
            <text>sa2:=0</text>
            <comment></comment>
          </simpleinstruction>
          <iteration>
            <condition>
              <text>i&lt;=n</text>
              <comment></comment>
            </condition>
            <loop>
              <sequence>
                <selection instructionsheight="115" conditionheight="33">
                  <condition>
                    <text>a[i]>max1</text>
                    <comment></comment>
                  </condition>
                  <ontrue>
                    <sequence>
                      <simpleinstruction>
                        <text>max2:=max1</text>
                        <comment></comment>
                      </simpleinstruction>
                      <simpleinstruction>
                        <text>max1:=a[i]</text>
                        <comment></comment>
                      </simpleinstruction>
                      <simpleinstruction>
                        <text>sa2:=1</text>
                        <comment></comment>
                      </simpleinstruction>
                    </sequence>
                  </ontrue>
                  <onfalse>
                    <sequence>
                      <selection instructionsheight="76" conditionheight="33">
                        <condition>
                          <text>a[i]&lt;max1</text>
                          <comment></comment>
                        </condition>
                        <ontrue>
                          <sequence>
                            <selection instructionsheight="37" conditionheight="33">
                              <condition>
                                <text>sa2=0</text>
                                <comment></comment>
                              </condition>
                              <ontrue>
                                <sequence>
                                  <simpleinstruction>
                                    <text>max2:=a[i]</text>
                                    <comment></comment>
                                  </simpleinstruction>
                                </sequence>
                              </ontrue>
                              <onfalse>
                                <sequence>
                                  <selection instructionsheight="15" conditionheight="15">
                                    <condition>
                                      <text>a[i]>max2</text>
                                      <comment></comment>
                                    </condition>
                                    <ontrue>
                                      <sequence>
                                        <simpleinstruction>
                                          <text>max2:=a[i]</text>
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
          <selection instructionsheight="14" conditionheight="55">
            <condition>
              <text>sa2=0</text>
              <comment></comment>
            </condition>
            <ontrue>
              <sequence>
                <outputinstruction>
                  <text>'max1', max1</text>
                  <comment></comment>
                </outputinstruction>
              </sequence>
            </ontrue>
            <onfalse>
              <sequence>
                <outputinstruction>
                  <text>'max1', max1, 'max2', max2</text>
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
            <text>'podales zle dane'</text>
            <comment></comment>
          </outputinstruction>
        </sequence>
      </onfalse>
    </selection>
  </sequence>
</nsscheme>

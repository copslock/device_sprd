#
### Modem Images for Building
### Included by product AndroidBoard.mk
#

ifneq ($(strip $(PRODUCT_MODEM_COPY_LIST)),)
MODEM_COPY_LIST := $(PRODUCT_MODEM_COPY_LIST)
else
MODEM_COPY_LIST := ltemodem ltedsp ltegdsp lteagdsp ltecdsp pmsys ltenvitem wcnmodem ltedeltanv gnssmodem
endif
$(info ***********************************************************)
$(info *        S E E K I N G   M O D E M   B I N S)
$(info * Place: $(BOARDDIR)/modem_bins/)
$(foreach modem,$(MODEM_COPY_LIST),$(if $(wildcard $(BOARDDIR)/modem_bins/$(modem).bin),\
$(call add-radio-file,modem_bins/$(modem).bin);\
$(info * Found: $(modem).bin),\
$(info * Lost : $(modem).bin)))
$(info ***********************************************************)

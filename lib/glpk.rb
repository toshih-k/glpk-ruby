require "glpk/version"
require 'ffi'

module GLPK
  extend FFI::Library
  ffi_lib ['libglpk']

  # optimization direction flag
  GLP_MIN = 1 # minimization
  GLP_MAX = 2 # maximization

  # kind of structural variable
  GLP_CV = 1 # continuous variable
  GLP_IV = 2 # integer variable
  GLP_BV = 3 # binary variable

  # type of auxiliary/structural variable
  GLP_FR = 1  # free (unbounded) variable
  GLP_LO = 2  # variable with lower bound
  GLP_UP = 3  # variable with upper bound
  GLP_DB = 4  # double-bounded variable
  GLP_FX = 5  # fixed variable

  # status of auxiliary/structural variable
  GLP_BS = 1 # basic variable
  GLP_NL = 2 # non-basic variable on lower bound
  GLP_NU = 3 # non-basic variable on upper bound
  GLP_NF = 4 # non-basic free (unbounded) variable
  GLP_NS = 5 # non-basic fixed variable

  # scaling options:
  GLP_SF_GM   = 0x01 # perform geometric mean scaling
  GLP_SF_EQ   = 0x10 # perform equilibration scaling
  GLP_SF_2N   = 0x20 # round scale factors to power of two
  GLP_SF_SKIP = 0x40 # skip if problem is well scaled
  GLP_SF_AUTO = 0x80 # choose scaling options automatically

  # solution indicator
  GLP_SOL = 1 # basic solution
  GLP_IPT = 2 # interior-point solution
  GLP_MIP = 3 # mixed integer solution

  # solution status
  GLP_UNDEF  = 1 # solution is undefined
  GLP_FEAS   = 2 # solution is feasible
  GLP_INFEAS = 3 # solution is infeasible
  GLP_NOFEAS = 4 # no feasible solution exists
  GLP_OPT    = 5 # solution is optimal
  GLP_UNBND  = 6 # solution is unbounded

    # enable/disable flag
  GLP_ON =  1 # enable something
  GLP_OFF = 0 # disable something

  # reason codes
  GLP_IROWGEN = 0x01 # request for row generation
  GLP_IBINGO  = 0x02 # better integer solution found
  GLP_IHEUR   = 0x03 # request for heuristic solution
  GLP_ICUTGEN = 0x04 # request for cut generation
  GLP_IBRANCH = 0x05 # request for branching
  GLP_ISELECT = 0x06 # request for subproblem selection
  GLP_IPREPRO = 0x07 # request for preprocessing

  # branch selection indicator
  GLP_NO_BRNCH = 0 # select no branch
  GLP_DN_BRNCH = 1 # select down-branch
  GLP_UP_BRNCH = 2 # select up-branch

  # return codes
  GLP_EBADB   = 0x01 # invalid basis
  GLP_ESING   = 0x02 # singular matrix
  GLP_ECOND   = 0x03 # ill-conditioned matrix
  GLP_EBOUND  = 0x04 # invalid bounds
  GLP_EFAIL   = 0x05 # solver failed
  GLP_EOBJLL  = 0x06 # objective lower limit reached
  GLP_EOBJUL  = 0x07 # objective upper limit reached
  GLP_EITLIM  = 0x08 # iteration limit exceeded
  GLP_ETMLIM  = 0x09 # time limit exceeded
  GLP_ENOPFS  = 0x0A # no primal feasible solution
  GLP_ENODFS  = 0x0B # no dual feasible solution
  GLP_EROOT   = 0x0C # root LP optimum not provided
  GLP_ESTOP   = 0x0D # search terminated by application
  GLP_EMIPGAP = 0x0E # relative mip gap tolerance reached
  GLP_ENOFEAS = 0x0F # no primal/dual feasible solution
  GLP_ENOCVG  = 0x10 # no convergence
  GLP_EINSTAB = 0x11 # numerical instability
  GLP_EDATA   = 0x12 # invalid data
  GLP_ERANGE  = 0x13 # result out of range

  # condition indicator
  GLP_KKT_PE = 1 # primal equalities
  GLP_KKT_PB = 2 # primal bounds
  GLP_KKT_DE = 3 # dual equalities
  GLP_KKT_DB = 4 # dual bounds
  GLP_KKT_CS = 5 # complementary slackness

  # MPS file format
  GLP_MPS_DECK = 1 # fixed (ancient)
  GLP_MPS_FILE = 2 # free (modern)

  # prob functions
  attach_function :glp_create_prob, [], :pointer
  attach_function :glp_delete_prob, [:pointer], :void
  attach_function :glp_set_prob_name, [:pointer, :string], :pointer
  attach_function :glp_get_prob_name, [:pointer], :string

  # obj functions
  attach_function :glp_set_obj_name, [:pointer, :string], :void
  attach_function :glp_set_obj_dir, [:pointer, :int], :void
  attach_function :glp_set_obj_coef, [:pointer, :int, :double], :void
  attach_function :glp_mip_obj_val, [:pointer], :double

  # row functions
  attach_function :glp_add_rows, [:pointer, :int], :int
  attach_function :glp_set_row_name, [:pointer, :int, :string], :void
  attach_function :glp_set_row_bnds, [:pointer, :int, :int, :double, :double], :void
  attach_function :glp_set_mat_row, [:pointer, :int, :int, :pointer, :pointer], :void
  attach_function :glp_mip_row_val, [:pointer, :int], :double

  # col functions
  attach_function :glp_add_cols, [:pointer, :int], :int
  attach_function :glp_set_col_name, [:pointer, :int, :string], :void
  attach_function :glp_set_col_bnds, [:pointer, :int, :int, :double, :double], :void
  attach_function :glp_set_mat_col, [:pointer, :int, :int, :pointer, :pointer], :void
  attach_function :glp_set_col_kind, [:pointer, :int, :int], :void
  attach_function :glp_mip_col_val, [:pointer, :int], :double

  attach_function :glp_load_matrix, [:pointer, :int, :pointer, :pointer, :pointer], :void

  # Simplex method routines
  attach_function :glp_simplex, [:pointer, :pointer], :int

  # Interior-point method routines
  attach_function :glp_intopt, [:pointer, :pointer], :int
  attach_function :glp_init_iocp, [:pointer], :void

  attach_function :glp_mip_status, [:pointer], :int
  attach_function :glp_term_out, [:int], :int

  # utility functions
  attach_function :glp_read_mps, [:pointer, :int, :pointer, :string], :int
  attach_function :glp_write_mps, [:pointer, :int, :pointer, :string], :int
  attach_function :glp_read_lp, [:pointer, :pointer, :string], :int
  attach_function :glp_write_lp, [:pointer, :pointer, :string], :int
  attach_function :glp_read_prob, [:pointer, :int, :string], :int
  attach_function :glp_write_prob, [:pointer, :int, :string], :int

  attach_function :glp_print_sol, [:pointer, :string], :int
end
